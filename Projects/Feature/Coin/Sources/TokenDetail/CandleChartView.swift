import UIKit
import RxSwift
import RxCocoa
import Domain

class CandleChartView: UIView {
  var data: [Candle]?
  private var highlightedCandleIndex: Int? = nil // Index of the currently highlighted candle

  private let tooltipLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 12)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.isHidden = true
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupGestureRecognizer()
    addSubview(tooltipLabel)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupGestureRecognizer()
    addSubview(tooltipLabel)
  }

  private func setupGestureRecognizer() {
    let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_: )))
    addGestureRecognizer(gestureRecognizer)
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    drawCandles(in: rect)
    if let index = highlightedCandleIndex {
      highlightCandle(at: index, in: rect)
    }
  }

  private func drawCandles(in rect: CGRect) {
    guard let data = data,
          !data.isEmpty else { return }

    let chartWidth = rect.width
    let chartHeight = rect.height * 0.8
    let maxPrice = data.map { $0.highPrice }.max() ?? 1
    let minPrice = data.map { $0.lowPrice }.min() ?? 0
    let priceRange = (maxPrice - minPrice) * 2
    let candleWidth = chartWidth / CGFloat(data.count)



    for (index, candle) in data.enumerated() {
      let x = CGFloat(index) * candleWidth
      let openY = chartHeight - ((candle.openingPrice - minPrice) / priceRange * chartHeight) + 20
      let closeY = chartHeight - ((candle.tradePrice - minPrice) / priceRange * chartHeight) + 20
      let highY = chartHeight - ((candle.highPrice - minPrice) / priceRange * chartHeight) + 20
      let lowY = chartHeight - ((candle.lowPrice - minPrice) / priceRange * chartHeight) + 20

//      let label = UILabel(frame: .init(x: x, y: highY, width: 100, height: 10))
//      label.text = "High"
//      label.textColor = .white

      let isBullish = candle.tradePrice > candle.openingPrice
      let color = isBullish ? UIColor.systemGreen : UIColor.systemRed
      color.setFill()
      color.setStroke()

      // Draw wick
      let wickPath = UIBezierPath()
      wickPath.move(to: CGPoint(x: x + candleWidth / 2, y: highY))
      wickPath.addLine(to: CGPoint(x: x + candleWidth / 2, y: lowY))
      wickPath.lineWidth = 2
      UIColor.systemGray.set()
      wickPath.stroke()


      // Draw rounded body
      let bodyRect = CGRect(
        x: x + candleWidth * 0.25,
        y: min(openY, closeY),
        width: candleWidth * 0.5,
        height: abs(openY - closeY)
      )
      let roundedBodyPath = UIBezierPath(roundedRect: bodyRect, cornerRadius: 4)
      color.setFill()
      roundedBodyPath.fill()
    }
  }

  private func highlightCandle(at index: Int, in rect: CGRect) {
    guard let data = data,
          index < data.count else { return }

    let chartWidth = rect.width
    let chartHeight = rect.height
    let candleWidth = chartWidth / CGFloat(data.count)
    let candle = data[index]
    let maxPrice = data.map { $0.highPrice }.max() ?? 1
    let minPrice = data.map { $0.lowPrice }.min() ?? 0
    let priceRange = maxPrice - minPrice

    let x = CGFloat(index) * candleWidth
    let highY = chartHeight - ((candle.highPrice - minPrice) / priceRange * chartHeight)

    // Update tooltip label
    tooltipLabel.text = """
        Open: \(candle.openingPrice)
        High: \(candle.highPrice)
        Low: \(candle.lowPrice)
        Close: \(candle.tradePrice)
        """
    let labelWidth: CGFloat = 100
    let labelHeight: CGFloat = 60
    tooltipLabel.frame = CGRect(
      x: max(0, min(x + candleWidth / 2 - labelWidth / 2, rect.width - labelWidth)),
      y: max(0, highY - labelHeight - 10),
      width: labelWidth,
      height: labelHeight
    )
    tooltipLabel.isHidden = false
  }

  @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
    guard let data = data else { return }
    let location = gesture.location(in: self)
    let chartWidth = bounds.width
    let candleWidth = chartWidth / CGFloat(data.count)

    let index = Int(location.x / candleWidth)
    if index >= 0 && index < data.count {
      highlightedCandleIndex = index
      setNeedsDisplay()
    }

    if gesture.state == .ended {
      tooltipLabel.isHidden = true
      highlightedCandleIndex = nil
      setNeedsDisplay()
    }
  }
}

extension Reactive where Base: CandleChartView {
  var candleData: Binder<[Candle]?> {
    return Binder(self.base) { view, candleData in
      view.data = candleData
    }
  }
}
