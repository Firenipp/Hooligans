//
//  FixtureCell.swift
//  Hooligans
//
//  Created by 정명곤 on 10/18/23.
//

import UIKit

final class FixtureCell: UICollectionViewCell {
    static let identifier = "fixtureCell"
    
    
    // MARK: - View Initialize
    private let homeTeamImage = UIImageView()
        .opacity(0.5)
        .contentMode(.scaleAspectFill)
        .clipsToBounds(true)
    
    private let awayTeamImage = UIImageView()
        .opacity(0.5)
        .contentMode(.scaleAspectFill)
        .clipsToBounds(true)
    
    // MARK: - Init Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func configureCell(fixture: Fixture) {
        homeTeamImage.image = UIImage(named: fixture.home)
        awayTeamImage.image = UIImage(named: fixture.away)
    }
    
}

extension FixtureCell {
    private func setupView() {
        let frameHeight = self.frame.height
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = frameHeight * 0.2
        
        self.addSubview(homeTeamImage)
        homeTeamImage.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.leading).offset(frameHeight * 0.25)
            make.width.height.equalTo(frameHeight * 0.8)
        }
        
        self.addSubview(awayTeamImage)
        awayTeamImage.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.trailing).inset(frameHeight * 0.25)
            make.width.height.equalTo(frameHeight * 0.8)
        }
        
    }
    
    func configure(home: String, away: String) {
        homeTeamImage.image = UIImage(named: home)
        awayTeamImage.image = UIImage(named: away)
    }
}