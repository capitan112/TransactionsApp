import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        let tableViewCoordinator = TransactionsViewCoordinator(navigationController: navigationController)
        coordinate(to: tableViewCoordinator)
    }
}
