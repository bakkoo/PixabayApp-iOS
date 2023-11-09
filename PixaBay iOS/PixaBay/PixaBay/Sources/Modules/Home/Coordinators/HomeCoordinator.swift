import Foundation
import UIKit

//MARK: - Home Coordinator Protocol

protocol HomeCoordinatorProtocol: AnyObject {
    func start()
    func showAuthorizationPage()
    func showDetailedPage(with hit: Hit)
}

//MARK: - Home Coordinator Implementation

class HomeCoordinator: HomeCoordinatorProtocol {
    private let navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "SecondaryButtonColor")
    }

    func start() {
        let homeViewController = HomeViewController.instantiate()
        homeViewController.coordinator = self
        navigationController?.setViewControllers([homeViewController], animated: true)
    }
    
    func showAuthorizationPage() {
        
    }
    
    func showDetailedPage(with hit: Hit) {
        let vc = DetailedPageTableViewController.instantiate()
        vc.coordinator = self
        vc.hit = hit
        navigationController?.pushViewController(vc, animated: true)
    }
}
