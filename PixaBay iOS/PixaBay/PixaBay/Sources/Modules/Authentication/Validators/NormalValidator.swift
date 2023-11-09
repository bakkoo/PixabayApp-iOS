//MARK: Normal validator implementation

struct NormalValidator: PBTextFieldValidator {
    func isValid(_ text: String) -> Bool { true }
    
    var errorMessage: String { "Normal field not valid" }
}
