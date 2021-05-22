//
//  BaseCollectionReusableView.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

import RxSwift

class BaseCollectionReusableView: UICollectionReusableView {
  // MARK: - Properties
  
  var reusableViewDisposeBag = DisposeBag()
  
  // MARK: - Overridden: UICollectionReusableView
  
  override func prepareForReuse() {
    super.prepareForReuse()
    reusableViewDisposeBag = DisposeBag()
  }
}
