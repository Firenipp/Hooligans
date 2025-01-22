import UIKit
import RxSwift
import Presentation
import Domain
import Data


final class HomeCoordinator: Coordinator {
  // MARK: - Property
  var parent: Coordinator?
  var childeren: [Coordinator] = []
  var navigationController: UINavigationController

  var disposeBag = DisposeBag()

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  // MARK: - Start
  func start() {
    let repository = RepositoryImpl()               // Data layer
    let useCase = CoinListUseCase(repository: repository)   // Domain layer
    let viewModel = MainViewModel(useCase: useCase)     // Presentation layer
    let viewController = MainViewController(viewModel: viewModel)

    viewModel.output.navigateToAuthCoordinator
      .subscribe(onNext: { [weak self] in
        let appCoordinator = self?.parent as! AppCoordinator
        appCoordinator.goToAuthCoordinator()
      })
      .disposed(by: disposeBag)

    navigationController.pushViewController(viewController, animated: true)
  }

}
