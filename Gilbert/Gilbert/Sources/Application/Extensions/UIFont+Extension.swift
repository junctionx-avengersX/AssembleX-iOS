//
//  UIFont+Extension.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

extension UIFont {
  
  enum FontType {
    case bold
    case medium
    case regular
    
    var fontName: String {
      switch self {
      case .regular:
        return "AppleSDGothicNeo-Regular"
      case .medium:
        return "AppleSDGothicNeo-Medium"
      case .bold:
        return "AppleSDGothicNeo-Bold"
      }
    }
  }
}

extension UIFont {
  
  static func font(
    weight: UIFont.FontType,
    size: CGFloat
  ) -> UIFont {
    UIFont(
      name: weight.fontName,
      size: size
    ) ?? UIFont.systemFont(ofSize: size)
  }
}
