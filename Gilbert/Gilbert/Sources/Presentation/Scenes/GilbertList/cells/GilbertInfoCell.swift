//
//  GilbertInfoCell.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

class GilbertInfoCell: BaseCollectionViewCell {
  
  // MARK: - UI Components
  
  private let backgroundCardView = UIView().then {
    $0.backgroundColor = .white
  }
  
  private let bottomGrayBackgroundView = UIView()
  
  private let feeInfoImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  private let feeInfoLabel = UILabel()
  
  private let userNameBoldLabel = UILabel()
  
  private let userNameLightLabel = UILabel()
  
  private let serviceCountLabel = GreenPaddingLabel()
  
  private let userProfileImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = 31
  }
  
  private let descriptionLabel = UILabel()
  
  private let checkMarkImageView = UIImageView()
  
  private let ratingStackView = UIStackView().then {
    $0.distribution = .fillEqually
    $0.alignment = .fill
    $0.axis = .horizontal
  }

  private var clappingViews = [UIImageView]()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  func configure(gilbertInfo: Gilbert) {
    
  }
}

// MARK: - SetupUI
extension GilbertInfoCell {
  private func setupUI() {
    contentView.addSubview(backgroundCardView)
    
    backgroundCardView.addSubviews(
      userNameBoldLabel,
      userNameLightLabel,
      userProfileImageView,
      descriptionLabel,
      ratingStackView,
      bottomGrayBackgroundView
    )
    
    bottomGrayBackgroundView.addSubview(feeInfoLabel)
    
    userProfileImageView.addSubview(checkMarkImageView)
  }
  
  private func layout() {
    backgroundCardView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.bottom.equalToSuperview().offset(-10)
    }
    
    bottomGrayBackgroundView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(32)
    }
    
    userNameBoldLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(16)
      $0.top.equalToSuperview().offset(20)
    }
    
    userNameLightLabel.snp.makeConstraints {
      $0.leading.equalTo(userNameBoldLabel.snp.trailing).offset(9)
      $0.centerY.equalTo(userNameBoldLabel)
    }
    
    serviceCountLabel.snp.makeConstraints {
      $0.leading.equalTo(userNameLightLabel.snp.trailing).offset(10)
      $0.centerY.equalTo(userNameBoldLabel)
    }
    
    userProfileImageView.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalToSuperview().offset(20)
      $0.width.height.equalTo(62)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.leading.equalTo(userNameBoldLabel)
      $0.top.equalTo(userNameBoldLabel.snp.bottom).offset(6)
    }
    
    ratingStackView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(16)
      $0.top.equalTo(descriptionLabel.snp.bottom).offset(6)
    }
  }
}


