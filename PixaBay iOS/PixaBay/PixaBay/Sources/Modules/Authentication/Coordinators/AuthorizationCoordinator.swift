import Foundation
import UIKit

//MARK: - Authorization Coordinator Protocol

protocol AuthorizationCoordinatorProtocol: AnyObject {
    func start()
    func showRegistrationPage()
    func showHomePage()
}

//MARK: - Authorization Coordinator Implementation

class AuthorizationCoordinator: AuthorizationCoordinatorProtocol {
    private let navigationController: UINavigationController?
    private let window: UIWindow?
    
    private var homeCoordinator: HomeCoordinatorProtocol?
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        navigationController?.navigationBar.backgroundColor = UIColor(named: "SecondaryButtonColor")
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    private func showAuthorizationPage() {
        let authorizationViewController = AuthorizationViewController.instantiate()
        authorizationViewController.coordinator = self
        navigationController?.pushViewController(authorizationViewController, animated: false)
    }
    
    func start() {
        showAuthorizationPage()
    }
    
    func showRegistrationPage() {
        let registrationViewController = RegistrationViewController.instantiate()
        registrationViewController.coordinator = self
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    func showHomePage() {
        homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator?.start()
    }
}
