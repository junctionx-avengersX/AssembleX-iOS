//
//  GilbertSmallCardView.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/23.
//

import Then
import UIKit

class GilbertSmallCardView: UIView {
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
    $0.layer.cornerRadius = 25
    $0.clipsToBounds = true
  }
  
  private let descriptionLabel = UILabel().then {
    $0.font = .font(weight: .regular, size: 12)
    $0.textColor = UIColor(rgb: "#999999")
  }

  private let ratingStackView = UIStackView().then {
    $0.distribution = .fillEqually
    $0.alignment = .fill
    $0.axis = .horizontal
  }
  
  private var thumbUpViews = [UIImageView]()
  
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
extension GilbertSmallCardView {
  private func setupUI() {
    self.do {
      $0.backgroundColor = .white
      $0.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
      $0.layer.shadowOpacity = 0.7
      $0.layer.shadowOffset = CGSize(width: 3, height: 3)
      $0.layer.cornerRadius = 3
    }
    addSubviews(
      userNameBoldLabel,
      userNameLightLabel,
      serviceCountLabel,
      userProfileImageView,
      descriptionLabel,
      ratingStackView
    )
    layout()
  }
  
  private func layout() {
    userNameBoldLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(13)
      $0.top.equalToSuperview().offset(16)
    }
    
    userNameLightLabel.snp.makeConstraints {
      $0.leading.equalTo(userNameBoldLabel.snp.trailing).offset(4)
      $0.centerY.equalTo(userNameBoldLabel)
    }
    
    serviceCountLabel.snp.makeConstraints {
      $0.leading.equalTo(userNameLightLabel.snp.trailing).offset(7)
      $0.centerY.equalTo(userNameBoldLabel)
    }
    
    userProfileImageView.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-16)
      $0.top.equalToSuperview().offset(16)
      $0.width.height.equalTo(50)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.leading.equalTo(userNameBoldLabel)
      $0.top.equalTo(userNameBoldLabel.snp.bottom).offset(6)
      $0.trailing.equalTo(userProfileImageView.snp.leading).offset(-10)
    }
    
    ratingStackView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(13)
      $0.top.equalTo(descriptionLabel.snp.bottom).offset(6)
      $0.height.equalTo(13)
      $0.width.equalTo(70)
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
