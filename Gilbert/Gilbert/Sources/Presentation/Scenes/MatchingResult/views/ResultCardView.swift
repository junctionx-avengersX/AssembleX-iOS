//
//  ResultCardView.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/23.
//

import UIKit

class ResultCardView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
    $0.image = UIImage(named: "temp3")
    $0.contentMode = .scaleAspectFit
  }
  
  func configure(gilbertInfo: Gilbert) {
    if let name = gilbertInfo.name {
      userNameBoldLabel.text = name
    }
    
    if let urlString = gilbertInfo.profileUrl,
       let url = URL(string: urlString) {
      profileImageView.kf.setImage(with: url)
    }
    
    if let rating = gilbertInfo.rating {
      for index in 0..<rating {
        thumbUpViews[index].image = UIImage(named: "thumbup_blank_img")?.withTintColor(UIColor(rgb: "#32d74b"))
      }
    }
  }
}

// MARK: - SetupUI
extension ResultCardView {
  private func setupUI() {
    backgroundColor = .white
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
    
    ratingStackView.snp.makeConstraints {
      $0.top.equalTo(userNameBoldLabel.snp.bottom).offset(14)
      $0.width.equalTo(139)
      $0.height.equalTo(24)
      $0.centerX.equalToSuperview()
    }
    
    imageView.snp.makeConstraints {
      $0.top.equalTo(ratingStackView.snp.bottom).offset(14)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalToSuperview().offset(-30)
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

