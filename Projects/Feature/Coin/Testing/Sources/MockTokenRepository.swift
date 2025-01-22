import Foundation
import Domain
import RxSwift


public final class MockTokenRepository: TokenRepository {
  private let clubList = [
    Token(clubId: UUID().uuidString, clubName: "MU", clubLogo: "", currentPrice: "100000", totalSupply: "10_000", createdAt: ""),
    Token(clubId: UUID().uuidString, clubName: "MCI", clubLogo: "", currentPrice: "100897", totalSupply: "10_000", createdAt: ""),
    Token(clubId: UUID().uuidString, clubName: "CHE", clubLogo: "", currentPrice: "100780", totalSupply: "10_000", createdAt: ""),
    Token(clubId: UUID().uuidString, clubName: "LIV", clubLogo: "", currentPrice: "1006786", totalSupply: "10_000", createdAt: ""),
    Token(clubId: UUID().uuidString, clubName: "TOT", clubLogo: "", currentPrice: "10067869", totalSupply: "10_000", createdAt: ""),
    Token(clubId: UUID().uuidString, clubName: "ARS", clubLogo: "", currentPrice: "100787", totalSupply: "10_000", createdAt: ""),
    Token(clubId: UUID().uuidString, clubName: "AVL", clubLogo: "", currentPrice: "100678", totalSupply: "10_000", createdAt: ""),
  ]

  private let exampleData: [Candle] = [
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T00:00:00", candleDateTimeKST: "2025-01-20T09:00:00", openingPrice: 432.81, highPrice: 432.98, lowPrice: 413.39, tradePrice: 414.78, timestamp: 1737446400000, candleAccTradePrice: 1200000000.0, candleAccTradeVolume: 28.5, prevClosingPrice: 41700000.0, changePrice: 100000.0, changeRate: 0.0024, convertedTradePrice: 41800.0),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T01:00:00", candleDateTimeKST: "2025-01-20T10:00:00", openingPrice: 414.78, highPrice: 430.0, lowPrice: 400.01, tradePrice: 414.32, timestamp: 1737448200000, candleAccTradePrice: 620000000.0, candleAccTradeVolume: 246.3, prevClosingPrice: 2505000.0, changePrice: 5000.0, changeRate: 0.002, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T02:00:00", candleDateTimeKST: "2025-01-20T11:00:00", openingPrice: 414.32, highPrice: 530.0, lowPrice: 410.23, tradePrice: 412.25, timestamp: 1737450000000, candleAccTradePrice: 320000000.0, candleAccTradeVolume: 620000.0, prevClosingPrice: 518.0, changePrice: 7.0, changeRate: 0.0135, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T03:00:00", candleDateTimeKST: "2025-01-20T12:00:00", openingPrice: 412.25, highPrice: 425.0, lowPrice: 410.0, tradePrice: 408.92, timestamp: 1737451800000, candleAccTradePrice: 1900000000.0, candleAccTradeVolume: 44.2, prevClosingPrice: 41800000.0, changePrice: 600000.0, changeRate: 0.0144, convertedTradePrice: 42400.0),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T04:00:00", candleDateTimeKST: "2025-01-20T13:00:00", openingPrice: 408.92, highPrice: 410.55, lowPrice: 407.77, tradePrice: 409.36, timestamp: 1737453600000, candleAccTradePrice: 720000000.0, candleAccTradeVolume: 284.1, prevClosingPrice: 2510000.0, changePrice: 20000.0, changeRate: 0.0079, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 409.37, highPrice: 435.0, lowPrice: 409.37, tradePrice: 412.38, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 412.38, highPrice: 415.01, lowPrice: 409.37, tradePrice: 413.28, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 413.28, highPrice: 435.0, lowPrice: 410.99, tradePrice: 433.01, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 433.01, highPrice: 435.0, lowPrice: 410.99, tradePrice: 433.01, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 433.01, highPrice: 444.08, lowPrice: 410.99, tradePrice: 444.08, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 444.08, highPrice: 452.75, lowPrice: 440.99, tradePrice: 450.88, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 450.88, highPrice: 452.75, lowPrice: 448.15, tradePrice: 450.02, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 450.02, highPrice: 480.16, lowPrice: 450.02, tradePrice: 476.18, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 476.18, highPrice: 490.56, lowPrice: 470.02, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 501.74, lowPrice: 488.62, tradePrice: 500.412, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),
    Candle(clubName: "Unified Club", candleDateTimeUTC: "2025-01-20T05:00:00", candleDateTimeKST: "2025-01-20T14:00:00", openingPrice: 490.14, highPrice: 490.14, lowPrice: 490.14, tradePrice: 490.14, timestamp: 1737455400000, candleAccTradePrice: 410000000.0, candleAccTradeVolume: 770000.0, prevClosingPrice: 525.0, changePrice: 5.0, changeRate: 0.0095, convertedTradePrice: nil),

  ]

  public init() {

  }

  public func fetchTokenList() -> Observable<[Token]> {
    return Observable<[Token]>.just(clubList)
  }

  public func fetchTokenDetail(of clubId: String) -> Observable<Token> {
    return Observable<Token>.just(clubList[0])
  }

  public func fetchTokenOrderBook(of clubId: String) -> Observable<[OrderBook]> {
    return Observable<[OrderBook]>.just([])
  }

  public func fetchCandleData(of clubId: String) -> Observable<[Candle]> {
    return Observable<[Candle]>.just(exampleData)
  }

}