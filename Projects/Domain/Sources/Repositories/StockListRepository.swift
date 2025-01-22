import Foundation
import RxSwift

protocol StockListRepository {
  
  func getStockList() -> Observable<[Coin]>

}
