//
//  UIView+Extension.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

internal extension UIView {
  func addSubviews(_ subviews: UIView...) {
    subviews.forEach(addSubview)
  }
}
