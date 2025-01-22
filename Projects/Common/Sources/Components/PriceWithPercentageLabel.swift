import UIKit


public final class PriceWithPercentageLabel: UIView {

  let priceLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  let percentageLabel: UILabel = {
    let label = UILabel()
    label.textColor = .red
    label.text = "+1.2%"
    return label
  }()

  public override init(frame: CGRect) {
    super.init(frame: frame)

    setComponent()
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  public func setup(current price: Int) {
    priceLabel.text = "\(setNumberFomatter(of: price))원"
  }

}


extension PriceWithPercentageLabel {
  private func setComponent() {
    addSubview(priceLabel)
    addSubview(percentageLabel)
  }

  private func setLayout() {
    priceLabel.snp.makeConstraints { make in
      make.top.leading.bottom.equalToSuperview()
    }

    percentageLabel.snp.makeConstraints { make in
      make.top.trailing.bottom.equalToSuperview()
      make.leading.equalTo(priceLabel.snp.trailing).offset(10)
    }
  }

  private func setNumberFomatter(of number: Int, style type: NumberFormatter.Style = .decimal) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = type
    return numberFormatter.string(for: number)!
  }
}
