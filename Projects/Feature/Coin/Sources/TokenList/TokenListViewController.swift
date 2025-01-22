import UIKit
import SnapKit
import RxSwift
import RxCocoa


public class TokenListViewController: UIViewController {
  private var viewModel: TokenListViewModel
  private var disposeBag = DisposeBag()

  let viewDidAppearTrigger = PublishSubject<Void>()

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(TokenListTableViewCell.self, forCellReuseIdentifier: TokenListTableViewCell.identifier)

    return tableView
  }()

  public init(viewModel: TokenListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBlue

    setView()
    setLayout()
    bind()


    viewDidAppearTrigger.onNext(())
  }

  func bind() {
    let input = TokenListViewModel.Input(viewDidAppear: viewDidAppearTrigger)

    let output = viewModel.transform(from: input)

    output.clubList
      .observe(on: MainScheduler.instance)
      .bind(to: tableView.rx.items(cellIdentifier: TokenListTableViewCell.identifier, cellType: TokenListTableViewCell.self)) { (row, token, cell) in
        cell.configure(club: token)
      }
      .disposed(by: disposeBag)
  }

}

extension TokenListViewController {
  func setView() {
    view.addSubview(tableView)
  }

  func setLayout() {
    tableView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
}
