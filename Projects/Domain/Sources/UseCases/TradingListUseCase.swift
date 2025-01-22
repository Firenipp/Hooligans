import Foundation
import RxSwift

final class TradingListUseCase {
  private let repository: TokenRepository

  init(repository: TokenRepository) {
    self.repository = repository
  }


//  public func getTradingList() -> Observable<[Coin]> {
//    return repository.getStockList()
//  }
}
