import UIKit
import RxSwift

public protocol TokenRepository {

  init()

  func fetchTokenList() -> Observable<[Token]>

  func fetchTokenDetail(of clubId: String) -> Observable<Token>

  func fetchTokenOrderBook(of clubId: String) -> Observable<[OrderBook]>

  func fetchCandleData(of clubId: String) -> Observable<[Candle]>
}

extension TokenRepository {
//  init() { }
}
