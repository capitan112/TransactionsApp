import Foundation
import UIKit

class TransactionsViewCoordinator: Coordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let transactionsViewController = TransactionsViewController.instantiate(storyboardName: "Main")
        let viewModel = TransactionsViewModel()

        transactionsViewController.viewModel = viewModel
        viewModel.fetchTransactions()
        transactionsViewController.title = "Transactions"
        navigationController.pushViewController(transactionsViewController, animated: true)
    }
}
