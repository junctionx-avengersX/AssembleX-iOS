import UIKit

import RxCocoa
import RxSwift

enum TabBarType {
  case home
  case gilbert
  case notification
  case mypage
}

class MainTabBarViewController : UITabBarController {
  // MARK: - Overridden: ParentClass
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBar.isTranslucent = false
    self.tabBar.backgroundColor = .white
    self.tabBar.tintColor = UIColor(named: "color_primery")
    self.tabBar.shadowImage = UIImage.asImage(color: .init(hex: "#e8ecf2"))
    setupTabBar()
    setupViewControllers()
  }
  
  // MARK: - Private methods
  private func setupViewControllers() {
    let firstController = createNavigationController(type: .home)
    let secondeController = createNavigationController(type: .gilbert)
    
    let thirdController = createNavigationController(type: .notification)
    let fourthController = createNavigationController(type: .mypage)
    viewControllers = [
      firstController,
      secondeController,
      thirdController,
      fourthController
    ]
  }
  
  private func setupTabBar() {
    UITabBar.appearance().tintColor = UIColor(rgb: "#32d74b")
  }
  
  private func createNavigationController(type: TabBarType) -> UIViewController {
    switch type {
    case .home:
      let navigationController = UINavigationController()
      let provider = ServiceProvider()
      let homeMapViewController = HomeMapViewController(reactor: .init(provider: provider))
      navigationController.pushViewController(homeMapViewController, animated: false)
      navigationController.tabBarItem = UITabBarItem(
        title: "Home",
        image: UIImage(named: "icon_map"),
        tag: 0
      )
      return navigationController
    case .gilbert:
      let navigationController = UINavigationController()
      let navigator = GilbertListNavigator(presenter: navigationController)
      let serviceProvider = ServiceProvider()
      let viewModel = GilbertListViewModel(
        provider: serviceProvider, gilbertInfoPublishRelay: PublishRelay<Gilbert>()
      )
      let gilbertListViewController = GilbertListViewController(viewModel: viewModel)
      navigationController.pushViewController(gilbertListViewController, animated: false)
      navigationController.tabBarItem = UITabBarItem(
        title: "Gilbert",
        image: UIImage(named: "icon_gillbert"),
        selectedImage: nil
      )
      return navigationController
    case .notification:
      let serviceProvider = ServiceProvider()
      let viewModel = SearchAddressViewModel(
        
        provider: serviceProvider, selectedAddressPublishRelay: PublishRelay<AddressDetailInfo?>()
      )
      let searchAddressViewController = SearchAddressViewController(viewModel: viewModel)
      searchAddressViewController.tabBarItem = UITabBarItem(
        title: "Notification",
        image: UIImage(named: "icon_noti"),
        selectedImage: nil
      )
      return searchAddressViewController
    case .mypage:
      let viewModel = MatchingResultViewModel()
      let matchingResultViewController = MatchingResultViewController(viewModel: viewModel)
      matchingResultViewController.tabBarItem = UITabBarItem(
        title: "My Page",
        image: UIImage(named: "icon_account"),
        selectedImage: nil
      )
      return matchingResultViewController
    }
  }
}
