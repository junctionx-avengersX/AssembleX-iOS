//
//  ResultCardView.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/23.
//

import UIKit

class ResultCardView: UIView {
  
  private let profileImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = 44
    $0.clipsToBounds = true
  }
  
  private let userNameBoldLabel = UILabel().then {
    $0.font = .font(weight: .bold, size: 16)
    $0.textColor = UIColor(rgb: "#030303")
    $0.textAlignment = .center
  }
  
  private let ratingStackView = UIStackView().then {
    $0.distribution = .fillEqually
    $0.alignment = .fill
    $0.axis = .horizontal
  }
  
  private var thumbUpViews = [UIImageView]()
  
  private let imageView = UIImageView().then {
    $0.image = UIImage(named: "")
    $0.contentMode = .scaleAspectFit
  }
  
  func configure(gilbertInfo: Gilbert) {
    if let name = gilbertInfo.name {
      userNameBoldLabel.text = name
    }
  }
}

// MARK: - SetupUI
extension ResultCardView {
  private func setupUI() {
    addSubviews(
      profileImageView,
      userNameBoldLabel,
      ratingStackView,
      imageView
    )
    layout()
  }
  
  private func layout() {
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
  }
}

