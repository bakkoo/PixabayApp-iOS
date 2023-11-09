//MARK: Age validator implementation

struct AgeValidator: PBTextFieldValidator {
    func isValid(_ text: String) -> Bool { text.isValidAge }
    
    var errorMessage: String { "Age not valid" }
}
