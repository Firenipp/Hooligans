
import Foundation
import RxSwift
import RxCocoa
import Domain


public final class SignUpViewModel {
  private let useCase: CoinListUseCase
  private let disposeBag = DisposeBag()

  struct Input {
    let viewDidAppear: Observable<Void>
    let tap1Button: Observable<Void>
    let tap2Button: Observable<Void>
  }

  public struct Output {
    public let navigateToTabBarCoordinator = PublishRelay<Void>()
    public let navigateToSignIn = PublishRelay<Void>()
  }

  public let output = Output()

  public init(useCase: CoinListUseCase) {
    self.useCase = useCase
  }

  func transform(from input: Input) -> Output {

    input.viewDidAppear.subscribe(onNext: {
      print("Sign up view did appear")
    })
    .disposed(by: disposeBag)

    input.tap1Button
      .bind(to: output.navigateToTabBarCoordinator)
      .disposed(by: disposeBag)

    input.tap2Button
      .bind(to: output.navigateToSignIn)
      .disposed(by: disposeBag)


    return output
  }

}
