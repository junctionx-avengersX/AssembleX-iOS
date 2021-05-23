//
//  TransportationView.swift
//  Gilbert
//
//  Created by Tom on 2021/05/23.
//

import UIKit

class TransportationView: UIButton {
  let mainImageView: UIImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  let nameLabel: UILabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16, weight: .semibold)
    $0.textColor = .black
    $0.textAlignment = .left
  }
  
  let subLabel: UILabel = UILabel().then {
    $0.font = .systemFont(ofSize: 12, weight: .regular)
    $0.textColor = .init(hex: "#999999")
    $0.numberOfLines = 0
    $0.textAlignment = .left
    $0.contentMode = .top
  }
  
  let bestLabel: UILabel = UILabel().then {
    $0.layer.cornerRadius = 4
    $0.clipsToBounds = true
    $0.backgroundColor = .init(hex: "#32d74b")
    $0.font = .systemFont(ofSize: 10, weight: .semibold)
    $0.textColor = .white
    $0.text = "BEST"
    $0.textAlignment = .center
  }
  
  init(image: UIImage?, name: String, subName: String, isShowBest: Bool = false) {
    super.init(frame: .zero)
    
    self.addSubview(mainImageView)
    mainImageView.image = image
    self.addSubview(nameLabel)
    nameLabel.text = name
    self.addSubview(subLabel)
    subLabel.text = subName
    self.addSubview(bestLabel)
    
    self.bestLabel.isHidden = !isShowBest
    
    self.mainImageView.snp.makeConstraints {
      $0.top.left.bottom.equalToSuperview()
      $0.width.equalTo(100)
    }
    
    self.nameLabel.snp.makeConstraints {
      $0.left.equalTo(self.mainImageView.snp.right).offset(16)
      $0.right.equalToSuperview()
      $0.centerY.equalToSuperview().offset(-12)
    }
    
    self.subLabel.snp.makeConstraints {
      $0.left.equalTo(self.mainImageView.snp.right).offset(16)
      $0.right.equalToSuperview()
      $0.centerY.equalToSuperview().offset(12)
    }
    
    self.bestLabel.snp.makeConstraints {
      $0.width.equalTo(35)
      $0.height.equalTo(20)
      $0.centerY.equalTo(self.nameLabel).offset(-6)
      $0.right.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

