//
//  GilbertInfoCell.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

import Kingfisher
import RxCocoa
import RxSwift

class GilbertInfoCell: BaseCollectionViewCell {
  
  lazy var backgroundButtonTap = backgroundButton.rx.tap
  
  // MARK: - UI Components
  
  private let backgroundCardView = UIView().then {
    $0.backgroundColor = .white
    $0.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
    $0.layer.shadowOpacity = 0.7
    $0.layer.shadowOffset = CGSize(width: 3, height: 3)
    $0.layer.cornerRadius = 3
  }
  
  private let bottomGrayBackgroundView = UIView().then {
    $0.backgroundColor = UIColor(rgb: "#f4f5f7")
  }
  
  private let feeInfoLabel = UIButton().then {
    $0.semanticContentAttribute = .forceLeftToRight
    $0.setImage(UIImage(named: "coin_stack"), for: .normal)
    $0.isUserInteractionEnabled = false
    $0.titleLabel?.textAlignment = .center
    $0.titleLabel?.font = .font(weight: .regular, size: 10)
    $0.setTitleColor(.black, for: .normal)
    $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
  }
  
  private let userNameBoldLabel = UILabel().then {
    $0.font = .font(weight: .bold, size: 16)
    $0.textColor = UIColor(rgb: "#030303")
  }
  
  private let userNameLightLabel = UILabel().then {
    $0.font = .font(weight: .regular, size: 16)
    $0.textColor = UIColor(rgb: "#030303")
  }
  
  private let serviceCountLabel = GreenPaddingLabel().then {
    $0.text = "30회"
    $0.isHidden = true
  }
  
  private let userProfileImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = 31
    $0.clipsToBounds = true
  }
  
  private let descriptionLabel = UILabel().then {
    $0.font = .font(weight: .regular, size: 12)
    $0.textColor = UIColor(rgb: "#999999")
  }
  
  private let checkMarkImageView = UIImageView()
  
  private let ratingStackView = UIStackView().then {
    $0.distribution = .fillEqually
    $0.alignment = .fill
    $0.axis = .horizontal
  }
  
  private var thumbUpViews = [UIImageView]()
  
  private var backgroundButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  func configure(gilbertInfo: Gilbert) {
    if let name = gilbertInfo.name {
      let splited = name.split(separator: " ")
      if splited.count == 2 {
        userNameBoldLabel.text = String(splited[0])
        userNameLightLabel.text = String(splited[1])
      }
    }
    
    if let urlString = gilbertInfo.profileUrl,
       let url = URL(string: urlString) {
      userProfileImageView.kf.setImage(with: url)
    }
    
    if let fee = gilbertInfo.cost {
      feeInfoLabel.setTitle(" Escort Fee: \(fee) won", for: .normal)
    }
    
    if let rating = gilbertInfo.rating {
      for index in 0..<rating {
        thumbUpViews[index].image = UIImage(named: "thumbup_blank_img")?.withTintColor(UIColor(rgb: "#32d74b"))
      }
    }
    
    if let count = gilbertInfo.guideCount, count > 0 {
      serviceCountLabel.text = "\(count) times"
      serviceCountLabel.isHidden = false
    } else {
      serviceCountLabel.isHidden = true
    }
    
    if let intro = gilbertInfo.introduction {
      descriptionLabel.text = intro
    }
  }
}

// MARK: - SetupUI
extension GilbertInfoCell {
  private func setupUI() {
    contentView.backgroundColor = UIColor(rgb: "#f4f5f7")
    contentView.addSubviews(
      backgroundCardView,
      backgroundButton
    )
    
    backgroundCardView.addSubviews(
      userNameBoldLabel,
      userNameLightLabel,
      serviceCountLabel,
      userProfileImageView,
      descriptionLabel,
      ratingStackView,
      bottomGrayBackgroundView
    )
    
    bottomGrayBackgroundView.addSubview(feeInfoLabel)
    
    userProfileImageView.addSubview(checkMarkImageView)
    
    layout()
  }
  
  private func layout() {
    backgroundCardView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.bottom.equalToSuperview().offset(-10)
    }
    
    backgroundButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.bottom.equalToSuperview().offset(-10)
    }
    
    bottomGrayBackgroundView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(32)
      $0.bottom.equalToSuperview()
    }
    
    userNameBoldLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(16)
      $0.top.equalToSuperview().offset(20)
    }
    
    userNameLightLabel.snp.makeConstraints {
      $0.leading.equalTo(userNameBoldLabel.snp.trailing).offset(4)
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
      $0.height.equalTo(16)
      $0.width.equalTo(90)
    }
    
    feeInfoLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    
    for _ in 0..<5 {
      let thumbUpView = UIImageView().then {
        $0.image = UIImage(named: "thumbup_blank_img")?.withTintColor(UIColor(rgb: "#999999"))
        $0.contentMode = .scaleAspectFit
      }
      thumbUpViews.append(thumbUpView)
      ratingStackView.addArrangedSubview(thumbUpView)
    }
  }
}


