import Foundation

class RegistrationViewModel {
    private let registrationRepository: RegistrationRepositoryProtocol
    private weak var coordinator: AuthorizationCoordinatorProtocol?

    init(registrationRepository: RegistrationRepositoryProtocol, coordinator: AuthorizationCoordinatorProtocol?) {
        self.registrationRepository = registrationRepository
        self.coordinator = coordinator
    }

    func registerUser(email: String?, password: String?, age: String?, completion: @escaping (Result<Void, RegistrationError>) -> ()) {
        guard let email = email, let password = password, let age = age else {
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

        guard (age.isValidAge || !age.isEmpty) && age.containsOnlyNumbers else {
            completion(.failure(.invalidAge))
            return
        }

        if let ageValue = age.toInt() {
            registrationRepository.registerUser(email: email, password: password, age: ageValue) { [weak self] result in
                completion(result)
                self?.coordinator?.showHomePage()
            }
        }
    }

}
