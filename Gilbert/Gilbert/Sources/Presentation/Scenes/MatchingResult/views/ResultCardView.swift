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
  
  private let ratingStackView = UIStackView().then {
    $0.distribution = .fillEqually
    $0.alignment = .fill
    $0.axis = .horizontal
  }
  
  private var thumbUpViews = [UIImageView]()

}

// MARK: - SetupUI
extension ResultCardView {
  private func setupUI() {
  }
}

