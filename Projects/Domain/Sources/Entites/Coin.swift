import Foundation


public struct Coin: Codable {
  public let id: String
  public let price: Double
  public let category: String
  public let time: Date
  public let isDelete: Bool

  public init(id: String, price: Double, category: String, time: Date, isDelete: Bool) {
    self.id = id
    self.price = price
    self.category = category
    self.time = time
    self.isDelete = isDelete
  }
}
