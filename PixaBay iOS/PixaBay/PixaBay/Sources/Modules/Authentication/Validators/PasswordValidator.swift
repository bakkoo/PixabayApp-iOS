//MARK: Password validator implementation

struct PasswordValidator: PBTextFieldValidator {
    func isValid(_ text: String) -> Bool { text.isValidPassword }
    
    var errorMessage: String { "Password not valid" }
}
