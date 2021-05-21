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
    switch state {
    case.login:
      rootViewController = MainTabBarViewController()
    case .logout:
      rootViewController = LoginViewController()
    }
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
  }
}
