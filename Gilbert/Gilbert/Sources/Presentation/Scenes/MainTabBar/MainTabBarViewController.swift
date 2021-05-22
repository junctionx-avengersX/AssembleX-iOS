import UIKit
enum TabBarType {
  case home
  case gilbert
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
    let secondeController = createNavigationController(type: .gilbert)
    viewControllers = [
      firstController,
      secondeController
    ]
  }
  private func createNavigationController(type: TabBarType) -> UINavigationController {
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
        provider: serviceProvider
      )
      let gilbertListViewController = GilbertListViewController(viewModel: viewModel)
      navigationController.pushViewController(gilbertListViewController, animated: false)
      navigationController.tabBarItem = UITabBarItem(
        title: "Gilbert",
        image: nil,
        selectedImage: nil
      )
      return navigationController
    }
  }
}
