//MARK: Email validator implementation

struct EmailValidator: PBTextFieldValidator {
    func isValid(_ text: String) -> Bool { text.isValidEmail }
    
    var errorMessage: String { "Email not valid" }
}

