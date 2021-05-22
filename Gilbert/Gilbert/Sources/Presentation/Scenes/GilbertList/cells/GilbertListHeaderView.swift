//
//  GilbertListHeaderView.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

class GilbertListHeaderView: BaseCollectionReusableView {
  
  private let titleLabel = UILabel().then {
    $0.font = .font(weight: .bold, size: 16)
    $0.textColor = UIColor(rgb: "#030303")
    $0.text = "Looking for Gillbert"
    $0.textAlignment = .center
  }
  
  private let descriptionLabel = UILabel().then {
    $0.font = .font(weight: .bold, size: 12)
    $0.textColor = UIColor(rgb: "#999999")
    $0.text = "close to each other within 5 minutes"
    $0.textAlignment = .center
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
}

// MARK: - SetupUI
extension GilbertListHeaderView {
  private func setupUI() {
    backgroundColor = UIColor(rgb: "#f4f5f7")
    addSubviews(
      titleLabel,
      descriptionLabel
    )
    layout()
  }
  
  private func layout() {
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalToSuperview().offset(20)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
    }
  }
}

