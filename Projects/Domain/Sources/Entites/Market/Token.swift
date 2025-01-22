import Foundation


public struct Token: Codable {
  public let clubId: String
  public let clubName: String
  public let clubLogo: String?
  public let currentPrice: String
  public let totalSupply: String
  public let createdAt: String

  public init(clubId: String,
              clubName: String,
              clubLogo: String?,
              currentPrice: String,
              totalSupply: String,
              createdAt: String) {
    self.clubId = clubId
    self.clubName = clubName
    self.clubLogo = clubLogo
    self.currentPrice = currentPrice
    self.totalSupply = totalSupply
    self.createdAt = createdAt
  }

  enum CodingKeys: String, CodingKey {
    case clubId = "club_id"
    case clubName = "club_name"
    case clubLogo = "club_logo"
    case currentPrice = "current_price"
    case totalSupply = "total_supply"
    case createdAt = "created_at"
  }
}


public struct Candle: Codable {
  public let clubName: String
  public let candleDateTimeUTC: String
  public let candleDateTimeKST: String
  public let openingPrice: Double
  public let highPrice: Double
  public let lowPrice: Double
  public let tradePrice: Double
  public let timestamp: Int
  public let candleAccTradePrice: Double
  public let candleAccTradeVolume: Double
  public let prevClosingPrice: Double
  public let changePrice: Double
  public let changeRate: Double
  public let convertedTradePrice: Double?

  public init(clubName: String,
              candleDateTimeUTC: String,
              candleDateTimeKST: String,
              openingPrice: Double,
              highPrice: Double,
              lowPrice: Double,
              tradePrice: Double,
              timestamp: Int,
              candleAccTradePrice: Double,
              candleAccTradeVolume: Double,
              prevClosingPrice: Double,
              changePrice: Double,
              changeRate: Double,
              convertedTradePrice: Double?) {
    self.clubName = clubName
    self.candleDateTimeUTC = candleDateTimeUTC
    self.candleDateTimeKST = candleDateTimeKST
    self.openingPrice = openingPrice
    self.highPrice = highPrice
    self.lowPrice = lowPrice
    self.tradePrice = tradePrice
    self.timestamp = timestamp
    self.candleAccTradePrice = candleAccTradePrice
    self.candleAccTradeVolume = candleAccTradeVolume
    self.prevClosingPrice = prevClosingPrice
    self.changePrice = changePrice
    self.changeRate = changeRate
    self.convertedTradePrice = convertedTradePrice
  }

  enum CodingKeys: String, CodingKey {
    case clubName
    case candleDateTimeUTC = "candle_date_time_utc"
    case candleDateTimeKST = "candle_date_time_kst"
    case openingPrice = "opening_price"
    case highPrice = "high_price"
    case lowPrice = "low_price"
    case tradePrice = "trade_price"
    case timestamp
    case candleAccTradePrice = "candle_acc_trade_price"
    case candleAccTradeVolume = "candle_acc_trade_volume"
    case prevClosingPrice = "prev_closing_price"
    case changePrice = "change_price"
    case changeRate = "change_rate"
    case convertedTradePrice = "converted_trade_price"
  }
}
