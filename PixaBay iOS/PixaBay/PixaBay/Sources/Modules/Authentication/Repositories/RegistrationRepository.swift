import Foundation

protocol RegistrationRepositoryProtocol {
    func registerUser(email: String,password: String, age: Int, completion: @escaping (Result<Void, RegistrationError>) -> ())
}

class RegistrationRepository: RegistrationRepositoryProtocol {
    
    func registerUser(email: String,password: String, age: Int, completion: @escaping (Result<Void, RegistrationError>) -> ()) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let isSuccess = false
            isSuccess ? completion(.success(())) : completion(.failure(.registrationFailed))
        }
    }
}
