import UIKit

class PBTextField: UITextField, UITextFieldDelegate {
    
    //MARK: - UI Components
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Variables
    
    var fieldType: PBTextFieldType = .normal {
        didSet {
            configureForFieldType()
        }
    }
    
    var errorBorderColor: UIColor = .red
    var defaultBorderColor: UIColor = .lightGray
    
    var validator: PBTextFieldValidator?

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Common Initialization
    
    private func commonInit() {
        delegate = self
        configureForFieldType()
        setupInputAccessoryView()
        setupErrorLabel()
        setupUI()
    }
    
    // MARK: - UI Configuration
    
    private func setupUI() {
        borderStyle = .none
        backgroundColor = .black
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        }
    }
    
    // MARK: - Field Type Configuration
    
    private func configureForFieldType() {
        switch fieldType {
        case .email:
            placeholder = "Email"
            keyboardType = .emailAddress
            validator = EmailValidator()
        case .password:
            placeholder = "Password"
            isSecureTextEntry = true
            validator = PasswordValidator()
        case .age:
            placeholder = "Age"
            keyboardType = .numberPad
            validator = AgeValidator()
        case .normal:
            placeholder = "Normal Field"
            validator = NormalValidator()
        }
        
        layer.borderColor = defaultBorderColor.cgColor
        layer.borderWidth = 0.8
    }
    
    // MARK: - Input Accessory View Setup
    
    private func setupInputAccessoryView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [flexibleSpace, doneButton]
        inputAccessoryView = toolbar
    }
    
    // MARK: - Error Label Setup
    
    private func setupErrorLabel() {
        addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        errorLabel.isHidden = true
    }
    
    // MARK: - Error Handling
    
    private func updateErrorMessage(message: String?) {
        errorLabel.text = message
        errorLabel.isHidden = message == nil
    }
    
    private func updateErrorState(hasError: Bool) {
        if let validator = validator {
            updateErrorMessage(message: hasError ? validator.errorMessage : nil)
            animateBorderColor(hasError: hasError)
        }
    }
    
    private func animateBorderColor(hasError: Bool = false) {
        layer.borderColor = hasError ? errorBorderColor.cgColor : defaultBorderColor.cgColor
        
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = defaultBorderColor.cgColor
        animation.toValue = hasError ? errorBorderColor : defaultBorderColor
        animation.duration = 0.2
        layer.add(animation, forKey: "borderColorAnimation")
    }
    
    // MARK: - Validation Handler
    
    private func handleValidation(newText: String) {
        if let validator = validator {
            let hasError = !validator.isValid(newText)
            updateErrorState(hasError: hasError)
        }
    }
    
    // MARK: - Action Handling
    
    @objc private func doneButtonTapped() { resignFirstResponder() }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        handleValidation(newText: (text as NSString?)?.replacingCharacters(in: range, with: string) ?? "")
        return true
    }
}
