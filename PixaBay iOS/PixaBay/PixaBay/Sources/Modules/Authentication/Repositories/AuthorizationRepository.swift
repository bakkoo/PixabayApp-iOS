import Foundation
import Networking

protocol UserRepositoryProtocol {
    func authorizeUser(email: String, password: String, completion: @escaping (Result<Void, AuthorizationError>) -> Void)
}

class UserRepository: UserRepositoryProtocol {
    func authorizeUser(email: String, password: String, completion: @escaping (Result<Void, AuthorizationError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let isSuccess = true
            isSuccess ? completion(.success(())) : completion(.failure(.authorizationFailed))
        }
    }
    
}
