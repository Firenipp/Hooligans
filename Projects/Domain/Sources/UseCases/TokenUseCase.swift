import UIKit
import RxSwift


public final class TokenUseCase {
  private let repository: TokenRepository

  public init(repository: TokenRepository) {
    self.repository = repository
  }

  public func getTokenList() -> Observable<[Token]> {
    return repository.fetchTokenList()
  }

  public func getCandleData() -> Observable<[Candle]> {
    return repository.fetchCandleData(of: "")
  }

}
