//
//  MainTabBarViewController.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

enum TabBarType {
  case home
}

class MainTabBarViewController : UITabBarController {
  
  // MARK: - Overridden: ParentClass
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewControllers()
  }
  
  // MARK: - Private methods
  
  private func setupViewControllers() {
    let firstController = createNavigationController(type: .home)
    viewControllers = [firstController]
  }
  
  private func createNavigationController(type: TabBarType) -> UINavigationController {
    switch type {
    case .home:
      let navigationController = UINavigationController()
      let navigator = HomeMapNavigator(presenter: navigationController)
      let useCase = HomeMapUseCase(repository: HomeMapRepositoryImpl())
      let viewModel = HomeMapViewModel(
        useCase: useCase,\
        navigator: navigator,
        provider: serviceProvider
      )
      let homeMapViewController = HomeMapViewController(viewModel: viewModel)
      navigationController.pushViewController(homeMapViewController, animated: false)
      navigationController.tabBarItem = UITabBarItem(
        title: "Home",
        image: nil,
        selectedImage: nil
      )
      return navigationController
    }
  }
}
