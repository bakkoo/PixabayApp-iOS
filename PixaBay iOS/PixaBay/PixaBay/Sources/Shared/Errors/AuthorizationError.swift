import Foundation

enum AuthorizationError: Error {
    case invalidInput
    case invalidEmail
    case invalidPassword
    case authorizationFailed
}

enum RegistrationError: Error {
    case invalidInput
    case invalidEmail
    case invalidPassword
    case invalidAge
    case registrationFailed
}

enum HitError: Error {
    case errorFetchingData
}
