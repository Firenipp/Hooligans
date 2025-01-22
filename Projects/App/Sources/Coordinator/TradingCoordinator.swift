import UIKit
import Presentation
import Domain
import Data

final class TradingCoordinator: Coordinator {
  // MARK: - Properties
  var parent: Coordinator?
  var childeren: [Coordinator] = []
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let repository = RepositoryImpl()               // Data layer
    let useCase = CoinListUseCase(repository: repository)   // Domain layer
    let viewModel = TradingViewModel(useCase: useCase)     // Presentation layer
    let viewController = TradingViewController(viewModel: viewModel)

    navigationController.pushViewController(viewController, animated: true)
  }
  
}
