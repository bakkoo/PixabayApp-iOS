//MARK: Validator protocol

protocol PBTextFieldValidator {
    func isValid(_ text: String) -> Bool
    var errorMessage: String { get }
}
