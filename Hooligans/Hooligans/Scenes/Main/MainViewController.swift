//
//  MainViewController.swift
//  Hooligans
//
//  Created by 정명곤 on 2023/09/14.
//

import UIKit
import SnapKit
import StompClientLib

protocol MainDisplayLogic: AnyObject {
    func displaySomething(viewModel: MainModels.Main.ViewModel)
}

class MainViewController: UIViewController {
    
    struct Item: Hashable, Equatable {
        let data: Any
        let section: MainModels.Section
        let identifier = UUID()
        
        init(data: Any, section: MainModels.Section) {
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
    
    typealias DataSource = UICollectionViewDiffableDataSource<Layouts.Main, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Layouts.Main, Item>
    
    private lazy var dataSource: DataSource = configureDataSource()
    private lazy var snapshot: Snapshot = Snapshot()
    
    // MARK: - Properties
    var interactor: (MainBusinessLogic & MainDataStore)?
    var router: MainRoutingLogic?
    
    // MARK: - View Initailize
    private let headerView = MainHeaderView()
    
    private var collectionView: UICollectionView = {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return Layouts.Main.allCases[section].section()
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .white
        
        collectionView.showsVerticalScrollIndicator = false
        

        return collectionView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
        bindView()
        interactor?.fetchMainSource(request: MainModels.Main.Request())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        setupView()
        registerCells()
    }

    private func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func registerCells() {
        collectionView.register(ChatCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ChatCollectionViewHeader.identifier)
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
        collectionView.register(FixtureCell.self, forCellWithReuseIdentifier: FixtureCell.identifier)
        collectionView.register(NewsPostCell.self, forCellWithReuseIdentifier: NewsPostCell.identifier)
    }
    
    private func bindView() {
        snapshot.appendSections([.profile, .fixture, .news])
        self.dataSource.apply(self.snapshot)
    }

}

extension MainViewController {
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.view.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(125)
        }
    }
    
    func routeToUserViewController() {
        router?.routeToUserInfo()
    }
  
    @objc func routeToChatRoom() {
        router?.routeToUserInfo()
    }
    
    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: self.collectionView) { collectionView, indexPath, item in
            switch item.section {
            case .profile:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier,
                                                   for: indexPath) as? ProfileCell else { return UICollectionViewCell() }
                if let data = item.data as? MainUser { cell.configureCell(user: data) }
                return cell
                
            case .fixture:
                 guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FixtureCell.identifier,
                                                                     for: indexPath) as? FixtureCell else { return UICollectionViewCell() }
                if let data = item.data as? Fixture { cell.configureCell(fixture: data) }
                return cell
                
            case .news:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsPostCell.identifier, for: indexPath) as? NewsPostCell else { return UICollectionViewCell() }
                if let data = item.data as? Post { cell.configureCell(post: data) }
                return cell
            }
            
        }
        
        configureHeader(of: dataSource)
        return dataSource
    }
    
    private func configureHeader(of dataSource: DataSource) {
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: ChatCollectionViewHeader.identifier,
                                                                       for: indexPath) as? ChatCollectionViewHeader
            
            return view
        }
    }
    
}

extension MainViewController: MainDisplayLogic {
    func displaySomething(viewModel: MainModels.Main.ViewModel) {
        DispatchQueue.main.async {
            // MARK: - User Profile
            let userItem = Item(data: viewModel.mainSource.user, section: .profile)
            self.snapshot.appendItems([userItem], toSection: .profile)
            
            // MARK: - Live Fixtures
            
            // MARK: - News Posts
            viewModel.mainSource.news.posts.forEach { post in
                let newsPostItem = Item(data: post, section: .news)
                self.snapshot.appendItems([newsPostItem], toSection: .news)
            }
            self.dataSource.apply(self.snapshot)
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let data = dataSource.snapshot(for: .news).items[indexPath.item].data as? Post
            guard let query = data?.href else { return }
            let webViewController = WebViewController(base: "https://sports.news.naver.com/", query: query)
            webViewController.modalPresentationStyle = .overCurrentContext
            navigationController?.present(webViewController, animated: true)
        }
    }
    
}
