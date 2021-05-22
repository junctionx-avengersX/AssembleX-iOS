//
//  GilbertDetailInfoCardView.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

class GilbertDetailInfoCardView: UIView {
  
  private let profileImageView = UIImageView()
  
  private let checkMarkImageView = UIImageView()
  
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
  
  private let ratingStackView = UIStackView().then {
    $0.distribution = .fillEqually
    $0.alignment = .fill
    $0.axis = .horizontal
  }
  
  private var thumbUpViews = [UIImageView]()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - SetupUI
extension GilbertDetailInfoCardView {
  private func setupUI() {
  }
}
