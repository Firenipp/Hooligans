import UIKit
import Domain
import Common

class TokenListTableViewCell: UITableViewCell {
  static let identifier = "tokenListTableViewCell"
  // MARK: - Property

  

  // MARK: - View component
  private let rankingLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .blue
    return label
  }()

  private let clubImage: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()

  private let clubNameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    return label
  }()

  private let priceWithPercentageLabel: PriceWithPercentageLabel = {
    let label = PriceWithPercentageLabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Life cycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setComponents()
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func configure(club token: Token) {
    rankingLabel.text = token.clubId
    clubNameLabel.text = token.clubName
    priceWithPercentageLabel.setup(current: Int(token.currentPrice)!)
  }

}

extension TokenListTableViewCell {
  private func setComponents() {
    addSubview(rankingLabel)
    addSubview(clubNameLabel)
    addSubview(clubImage)
    addSubview(priceWithPercentageLabel)
  }

  private func setLayout() {
    rankingLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().inset(10)
      make.width.height.equalTo(30)
    }

    clubNameLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.leading.equalTo(rankingLabel.snp.trailing).offset(20)
//      make.trailing.equalToSuperview().inset(20)
      make.height.equalTo(30)
    }

    priceWithPercentageLabel.snp.makeConstraints { make in
      make.top.equalTo(clubNameLabel.snp.bottom).offset(6)
      make.leading.equalTo(clubNameLabel.snp.leading)
      make.bottom.equalToSuperview().inset(10)
    }
  }

  
}
