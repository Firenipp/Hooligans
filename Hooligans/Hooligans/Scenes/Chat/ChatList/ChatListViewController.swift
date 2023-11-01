//
//  ChatPageViewController.swift
//  Hooligans
//
//  Created by 정명곤 on 10/19/23.
//

import UIKit
import StompClientLib

protocol ChatListDisplayLogic: AnyObject {
    func displayFixtureList(viewModel: ChatListModels.FixtureList.ViewModel)
    func displayChatRoomList(viewModel: ChatListModels.ChatRoomList.ViewModel)
}

class ChatListViewController: UIViewController {

    struct Item: Hashable {

        let data: Any
        let section: ChatListModels.Section
        let identifier = UUID()

        init(data: Any, section: ChatListModels.Section) {
            self.data = data
            self.section = section
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(self.identifier)
        }

        static func == (lhs: Item, rhs: Item) -> Bool {
            lhs.identifier == rhs.identifier
        }

    }

    var interactor: (ChatListBusinessLogic & ChatListDataStore)?
    var router: ChatListRoutingLogic?

    // MARK: - View Initialize
    typealias DataSource = UICollectionViewDiffableDataSource<Layouts.Chat, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Layouts.Chat, Item>

    private lazy var dataSource: DataSource = configureDataSource()
    private lazy var snapshot: Snapshot = Snapshot()

    private var collectionView: UICollectionView = {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return Layouts.Chat.allCases[section].section()
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.showsVerticalScrollIndicator = false
        //        collectionView.isScrollEnabled = false

        return collectionView
    }()

    private var containerView: UIPageViewController = UIPageViewController()

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
        setupView()
        bindView()
        interactor?.fetchChatRoomList(request: ChatListModels.ChatRoomList.Request())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        registerCells()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setup() {
        let viewController = self
        let interactor = ChatListInteractor()
        let presenter = ChatListPresenter()
        let router = ChatListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func registerCells() {
        collectionView.register(ChatCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ChatCollectionViewHeader.identifier)
        collectionView.register(TabItemCell.self, forCellWithReuseIdentifier: TabItemCell.identifier)
        collectionView.register(FixtureCell.self, forCellWithReuseIdentifier: FixtureCell.identifier)
        collectionView.register(TeamChatRoomCell.self, forCellWithReuseIdentifier: TeamChatRoomCell.identifier)
    }


}

extension ChatListViewController {
    private func setupView() {

        self.view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }


    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: self.collectionView) { collectionView, indexPath, item in
            switch item.section {
            case .tabItem:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabItemCell.identifier,
                                                                    for: indexPath) as? TabItemCell else { return UICollectionViewCell() }
                if let data = item.data as? TabItem { cell.configureCell(item: data) }

                return cell

            case .pageView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamChatRoomCell.identifier,
                                                              for: indexPath) as? TeamChatRoomCell
                if let data = item.data as? ChatRoom { cell?.configureCell(chatRoom: data) }
                cell?.clipsToBounds = true
                cell?.alpha = 0
                return cell
            }
        }

        configureHeader(of: dataSource)
        return dataSource
    }

    func configureHeader(of dataSource: DataSource) {
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: ChatCollectionViewHeader.identifier,
                                                                       for: indexPath) as? ChatCollectionViewHeader

            return view
        }
    }

    private func bindView() {
        snapshot.appendSections([.tabItem, .pageView])
        snapshot.appendItems([Item(data: TabItem(title: "Fixtures", isTabbed: true), section: .tabItem), Item(data: TabItem(title: "Team", isTabbed: false), section: .tabItem)], toSection: .tabItem)
        self.dataSource.apply(self.snapshot)
    }

}

extension ChatListViewController: ChatListDisplayLogic {
    func displayFixtureList(viewModel: ChatListModels.FixtureList.ViewModel) {
        //        DispatchQueue.main.async {
        //            viewModel.fixtures.forEach { fixture in
        //                let fixtureItem = Item(data: fixture, section: .pageView)
        //                self.snapshot.appendItems([fixtureItem], toSection: .pageView)
        //                self.dataSource.apply(self.snapshot)
        //            }
        //        }
    }

    func displayChatRoomList(viewModel: ChatListModels.ChatRoomList.ViewModel) {
        DispatchQueue.main.async {
            viewModel.chatRooms.forEach { chatRoom in
                let chatRoomItem = Item(data: chatRoom, section: .pageView)
                self.snapshot.appendItems([chatRoomItem], toSection: .pageView)
                self.dataSource.apply(self.snapshot)
            }
        }
    }
}

extension ChatListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.section == 1 {
            // 2. Retrieve the item associated with the selected cell from the data source
            let selectedItem = dataSource.itemIdentifier(for: indexPath)
            guard let data = selectedItem?.data as? ChatRoom else { return }

            router?.routeToChatView(chatRoom: data)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
        }
    }
}

