//
//  AddressInfoCell.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

class AddressInfoCell: BaseCollectionViewCell {
  
  lazy var backgroundButtonTap = backgroundButton.rx.tap

  private let imageView = UIImageView().then {
    $0.image = UIImage(named: "marker_img")
  }
  
  private let titleLabel = UILabel().then {
    $0.font = .font(weight: .regular, size: 14)
    $0.textColor = UIColor(rgb: "#030303")
  }
  
  private let descriptionLabel = UILabel().then {
    $0.font = .font(weight: .regular, size: 12)
    $0.textColor = UIColor(rgb: "#999999")
  }
  
  private let backgroundButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  func configure(addressInfo: AddressDetailInfo) {
    if let title = addressInfo.title {
      titleLabel.text = title
    }
    
    if let roadAddress = addressInfo.roadAddress {
      descriptionLabel.text = roadAddress
    }
  }
}

// MARK: - SetupUI
extension AddressInfoCell {
  private func setupUI() {
    contentView.addSubviews(
      imageView,
      titleLabel,
      descriptionLabel
    )
    layout()
  }
  
  private func layout() {
    imageView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(24)
      $0.top.equalToSuperview().offset(10)
      $0.width.height.equalTo(16)
    }
    
    titleLabel.snp.makeConstraints {
      $0.centerY.equalTo(imageView)
      $0.leading.equalTo(imageView.snp.trailing).offset(10)
      $0.trailing.equalToSuperview().offset(20)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.leading.equalTo(titleLabel)
      $0.top.equalTo(titleLabel.snp.bottom).offset(4)
      $0.trailing.equalToSuperview().offset(20)
    }
  }
}

