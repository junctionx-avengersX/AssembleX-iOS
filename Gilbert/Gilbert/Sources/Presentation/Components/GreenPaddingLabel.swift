//
//  GreenPaddingLabel.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

class GreenPaddingLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    baseViewSetup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func baseViewSetup() {
    backgroundColor = UIColor(rgb: "#32d74b")
    textColor = .white
    textAlignment = .center
    font = .font(weight: .medium, size: 10)
    layer.cornerRadius = 7
    clipsToBounds = true
  }
  
  override var intrinsicContentSize: CGSize {
    let original = super.intrinsicContentSize
    
    return CGSize(width: original.width + 12, height: original.height + 10)
  }
}
