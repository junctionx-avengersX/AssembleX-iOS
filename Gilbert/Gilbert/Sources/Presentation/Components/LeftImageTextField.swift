//
//  LeftImageTextField.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/23.
//

import UIKit

class LeftImageTextField: UITextField {
  
  let displacement: CGFloat = 20
  
  required override public init(frame: CGRect) {
    super.init(frame: frame)
    sharedSetup()
  }
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    sharedSetup()
  }
  
  func sharedSetup() {
    self.leftViewMode = .always
    let imageView = UIImageView(image: UIImage(named: "green_oval"))
    imageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    leftView = imageView
  }
  
  override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    var textRect = super.leftViewRect(forBounds: bounds)
    textRect.origin.x += displacement
    return textRect
  }
  
  // placeholder position
  override func textRect(forBounds bounds: CGRect) -> CGRect
  {
    var textRect = super.textRect(forBounds: bounds)
    textRect.origin.x += displacement
    return textRect
  }
  
  // text position
  override func editingRect(forBounds bounds: CGRect) -> CGRect
  {
    var textRect = super.editingRect(forBounds: bounds)
    textRect.origin.x += displacement
    return textRect
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect
  {
    return bounds
  }
}

