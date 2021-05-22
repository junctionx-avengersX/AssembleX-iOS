import UIKit
enum TabBarType {
  case home
  case gillbert
  case noti
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
    
    setupViewControllers()
  }
  // MARK: - Private methods
  private func setupViewControllers() {
    viewControllers = [
      createNavigationController(type: .home),
      createNavigationController(type: .gillbert),
      createNavigationController(type: .noti),
      createNavigationController(type: .mypage)
    ]
  }
  private func createNavigationController(type: TabBarType) -> UINavigationController {
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
    case .gillbert:
      let navigationController: UINavigationController = .init()
      navigationController.tabBarItem = UITabBarItem(title: "Gillbert", image: UIImage(named: "icon_gillbert"), tag: 1)
      return navigationController
    case .noti:
      let navigationController: UINavigationController = .init()
      navigationController.tabBarItem = UITabBarItem(title: "Noti", image: UIImage(named: "icon_noti"), tag: 2)
      return navigationController
    case .mypage:
      let navigationController: UINavigationController = .init()
      navigationController.tabBarItem = UITabBarItem(title: "Mypage", image: UIImage(named: "icon_account"), tag: 3)
      return navigationController
    }
  }
}
