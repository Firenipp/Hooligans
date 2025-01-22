import Foundation
import Domain
import RxSwift
import RxCocoa


final public class TokenDetailViewModel {
  // MARK: - Properties
  private let tokenUseCase: TokenUseCase
  private let disposeBag = DisposeBag()

  struct Input {
    let viewDidAppear: Observable<Void>
  }

  struct Output {
    public let candleData = PublishRelay<[Candle]>()
  }

  let output = Output()
  

  // MARK: - LifeCycle
  public init(useCase: TokenUseCase) {
    self.tokenUseCase = useCase
  }

  func transform(from input: Input) -> Output {
    input.viewDidAppear
      .flatMap { [weak self] _ -> Observable<[Candle]> in
        guard let self = self else { return Observable.just([]) }
        return tokenUseCase.getCandleData()
      }
      .bind(to: output.candleData)
      .disposed(by: disposeBag)

    return output
  }
}
