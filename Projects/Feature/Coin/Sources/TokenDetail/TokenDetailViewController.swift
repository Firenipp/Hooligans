import UIKit
import RxSwift
import RxCocoa

public final class TokenDetailViewController: UIViewController {
  // MARK: - Properties
  private var tokenDetailViewModel: TokenDetailViewModel
  private var disposBag = DisposeBag()

  private var viewDidAppearTrigger = PublishSubject<Void>()

  private let candleChartView = CandleChartView()

  let headerLabel: UILabel = {
    let label = UILabel()
    label.text = "테슬라"
    label.font = .boldSystemFont(ofSize: 22)
    return label
  }()

  let priceLabel: UILabel = {
    let label = UILabel()
    label.text = "$419.20"
    label.font = .boldSystemFont(ofSize: 30)
    return label
  }()

//  let headerLabel: UILabel = {
//    let label = UILabel()
//    label.text = "테슬라"
//    return label
//  }()


  // MARK: - Lifecycle
  public init(tokenDetailViewModel: TokenDetailViewModel) {
    self.tokenDetailViewModel = tokenDetailViewModel
    super.init(nibName: nil, bundle: nil)
  }

  required public init?(coder: NSCoder) {
    fatalError()
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    setComponents()
    setLayout()
    bind()

    viewDidAppearTrigger.onNext(())
  }

  func bind() {
    let input = TokenDetailViewModel.Input(viewDidAppear: viewDidAppearTrigger)

    let output = tokenDetailViewModel.transform(from: input)
    
    output.candleData
      .observe(on: MainScheduler.instance)
      .bind(to: candleChartView.rx.candleData)
      .disposed(by: disposBag)

  }


}

extension TokenDetailViewController {
  private func setComponents() {
    view.addSubview(headerLabel)
    view.addSubview(priceLabel)
    view.addSubview(candleChartView)
  }

  private func setLayout() {
    headerLabel.snp.makeConstraints { make in
      make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
//      make.height.equalTo(10)
    }

    priceLabel.snp.makeConstraints { make in
      make.top.equalTo(headerLabel.snp.bottom).offset(10)
      make.leading.equalTo(headerLabel.snp.leading)
      make.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
//      make.height.equalTo(20)
    }

    candleChartView.snp.makeConstraints { make in
      make.top.equalTo(priceLabel.snp.bottom).offset(30)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
    }
  }
}
