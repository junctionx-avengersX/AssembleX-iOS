//
//  ApplicationNavigator.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

enum RootState {
  case login
  case logout
}

final class ApplicationNavigator {
  static let shared = ApplicationNavigator()
  
  private init() { }
  
  func setupRoot(window: UIWindow, state: RootState) {
    var rootViewController: UIViewController
    
    //window.rootViewController = rootViewController
    window.makeKeyAndVisible()
  }
}
