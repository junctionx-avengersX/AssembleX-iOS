//
//  UIViewControllerExtensions.swift
//  Gilbert
//
//  Created by Tom on 2021/05/23.
//

import UIKit

extension UIViewController {
  func hideKeyboardWhenTappedAround(cancelsTouchesInView: Bool) {
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(hideKeyboard))
    
    tapGesture.cancelsTouchesInView = cancelsTouchesInView
    self.view.addGestureRecognizer(tapGesture)
  }
  
  @objc func hideKeyboard() {
    view.endEditing(true)
  }
}
