import UIKit

import RxCocoa
import RxSwift

enum TabBarType {
  case home
  case gilbert
  case notification
}

class MainTabBarViewController : UITabBarController {
  // MARK: - Overridden: ParentClass
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
    setupViewControllers()
  }
  
  // MARK: - Private methods
  private func setupViewControllers() {
    let firstController = createNavigationController(type: .home)
    let secondeController = createNavigationController(type: .gilbert)
    
    let thirdController = createNavigationController(type: .notification)
    viewControllers = [
      firstController,
      secondeController,
      thirdController
    ]
  }
  
  private func setupTabBar() {
    UITabBar.appearance().tintColor = UIColor(rgb: "#32d74b")
  }
  
  private func createNavigationController(type: TabBarType) -> UIViewController {
    switch type {
    case .home:
      let navigationController = UINavigationController()
      let navigator = HomeMapNavigator(presenter: navigationController)
      let useCase = HomeMapUseCase(repository: HomeMapRepositoryImpl())
      let serviceProvider = ServiceProvider()
      let viewModel = HomeMapViewModel(
        useCase: useCase,
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
    case .gilbert:
      let navigationController = UINavigationController()
      let navigator = GilbertListNavigator(presenter: navigationController)
      let serviceProvider = ServiceProvider()
      let viewModel = GilbertListViewModel(
        navigator: navigator,
        provider: serviceProvider, gilbertInfoPublishRelay: PublishRelay<Gilbert>()
      )
      let gilbertListViewController = GilbertListViewController(viewModel: viewModel)
      navigationController.pushViewController(gilbertListViewController, animated: false)
      navigationController.tabBarItem = UITabBarItem(
        title: "Gilbert",
        image: UIImage(named: "gilbert_tab_img"),
        selectedImage: nil
      )
      return navigationController
    case .notification:
      let serviceProvider = ServiceProvider()
      let viewModel = SearchAddressViewModel(
        
        provider: serviceProvider, selectedAddressPublishRelay: PublishRelay<AddressDetailInfo>()
      )
      let searchAddressViewController = SearchAddressViewController(viewModel: viewModel)
      searchAddressViewController.tabBarItem = UITabBarItem(
        title: "Notification",
        image: UIImage(named: ""),
        selectedImage: nil
      )
      return searchAddressViewController
    }
  }
}
