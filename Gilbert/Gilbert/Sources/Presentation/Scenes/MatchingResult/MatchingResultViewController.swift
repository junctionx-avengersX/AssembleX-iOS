//
//  MatchingResultViewController.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

class MatchingResultViewController: BaseViewController {
  
  private let titleLabel = UILabel().then {
    $0.numberOfLines = 0
    $0.font = .font(weight: .bold, size: 16)
  }
  
  private let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  private let grayBottomFeeLabel = UIButton().then {
    $0.backgroundColor = UIColor(rgb: "#f4f5f7")
    $0.setImage(UIImage(named: "coin_stack"), for: .normal)
    $0.semanticContentAttribute = .forceLeftToRight
    $0.titleLabel?.font = .font(weight: .regular, size: 10)
  }
  
  private let bottomSendButton = UIButton().then {
    $0.setTitle("Send", for: .normal)
    $0.titleLabel?.font = .font(weight: .bold, size: 14)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = UIColor(rgb: "#32d74b")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
}

// MARK: - SetupUI
extension MatchingResultViewController {
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubviews(
      titleLabel,
      imageView,
      grayBottomFeeLabel,
      bottomSendButton
    )
    layout()
  }
  
  private func layout() {
    titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(40)
    }
    
    imageView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(40)
    }
    
    bottomSendButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(20)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.height.equalTo(48)
    }
    
    grayBottomFeeLabel.snp.makeConstraints {
      $0.bottom.equalTo(bottomSendButton.snp.top).offset(-13)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.height.equalTo(32)
    }
  }
}
