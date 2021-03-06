//
//  BaseCollectionViewCell.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
  // MARK: - Properties
  
  var cellDisposeBag = DisposeBag()
  
  // MARK: - Overridden: UICollectionReusableView
  
  override func prepareForReuse() {
    super.prepareForReuse()
    cellDisposeBag = DisposeBag()
  }
}

