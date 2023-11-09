import Foundation

class AuthorizationViewModel {
    private let userRepository: UserRepositoryProtocol
    private weak var coordinator: AuthorizationCoordinatorProtocol?

    init(userRepository: UserRepositoryProtocol, coordinator: AuthorizationCoordinatorProtocol?) {
        self.userRepository = userRepository
        self.coordinator = coordinator
    }

    func authorizeUser(email: String?, password: String?, completion: @escaping (Result<Void, AuthorizationError>) -> ()) {
        guard let email = email, let password = password else {
            completion(.failure(.invalidInput))
            return
        }

        guard email.isValidEmail || !email.isEmpty else {
            completion(.failure(.invalidEmail))
            return
        }

        guard password.isValidPassword || !password.isEmpty else {
            completion(.failure(.invalidPassword))
            return
        }

        userRepository.authorizeUser(email: email, password: password) {[weak self] result in
            DispatchQueue.main.async {
                self?.coordinator?.showHomePage()
            }
            completion(result)
        }
    }
}
