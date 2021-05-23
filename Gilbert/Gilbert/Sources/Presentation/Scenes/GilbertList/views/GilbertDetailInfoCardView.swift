//
//  GilbertDetailInfoCardView.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

import Kingfisher

class GilbertDetailInfoCardView: UIView {
  
  lazy var bottomAccompanyButtonTap = bottomAccompanyButton.rx.tap
  
  private let profileImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = 44
    $0.clipsToBounds = true
  }
  
  private let checkMarkImageView = UIImageView()
  
  private let bottomGrayBackgroundView = UIImageView().then {
    $0.image = UIImage(named: "temp4")
    $0.contentMode = .scaleAspectFit
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
    $0.textAlignment = .center
  }
  
  private let descriptionLabel = UILabel().then {
    $0.font = .font(weight: .regular, size: 12)
    $0.textColor = UIColor(rgb: "#999999")
    $0.textAlignment = .center
  }
  
  private let ratingStackView = UIStackView().then {
    $0.distribution = .fillEqually
    $0.alignment = .fill
    $0.axis = .horizontal
  }
  
  private var thumbUpViews = [UIImageView]()
  
  private let bottomAccompanyButton = UIButton().then {
    $0.setTitle("Accompany", for: .normal)
    $0.titleLabel?.font = .font(weight: .bold, size: 14)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = UIColor(rgb: "#32d74b")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(gilbertInfo: Gilbert) {
    if let name = gilbertInfo.name {
      userNameBoldLabel.text = name
    }
    
    if let urlString = gilbertInfo.profileUrl,
       let url = URL(string: urlString) {
      profileImageView.kf.setImage(with: url)
    }
    
    if let fee = gilbertInfo.cost {
      feeInfoLabel.setTitle(" Escort Fee: \(fee) WON", for: .normal)
    }
    
    if let rating = gilbertInfo.rating {
      for index in 0..<rating {
        thumbUpViews[index].image = UIImage(named: "thumbup_blank_img")?.withTintColor(UIColor(rgb: "#32d74b"))
      }
    }
    
    if let intro = gilbertInfo.introduction {
      descriptionLabel.text = intro
    }
  }
}

// MARK: - SetupUI
extension GilbertDetailInfoCardView {
  private func setupUI() {
    backgroundColor = .white
    layer.cornerRadius = 5
    
    addSubviews(
      profileImageView,
      bottomGrayBackgroundView,
      feeInfoLabel,
      userNameBoldLabel,
      descriptionLabel,
      ratingStackView,
      bottomAccompanyButton
    )
    
    layout()
  }
  
  private func layout() {
    bottomAccompanyButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-24)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.height.equalTo(48)
    }
    
    feeInfoLabel.snp.makeConstraints {
      $0.bottom.equalTo(bottomAccompanyButton.snp.top).offset(-18)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
    }
    
    profileImageView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(24)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(88)
    }
    
    userNameBoldLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(12)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(userNameBoldLabel.snp.bottom).offset(8)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
    }
    
    ratingStackView.snp.makeConstraints {
      $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
      $0.width.equalTo(88)
      $0.height.equalTo(16)
      $0.centerX.equalToSuperview()
    }
    
    bottomGrayBackgroundView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(ratingStackView.snp.bottom).offset(18)
      $0.width.equalTo(251)
      $0.height.equalTo(118)
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
