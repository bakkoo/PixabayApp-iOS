import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 25
        return stackView
    }()
    
    private let emailTextField: PBTextField = {
        let textField = PBTextField()
        textField.fieldType = .email
        return textField
    }()
    
    private let passwordTextField: PBTextField = {
        let textField = PBTextField()
        textField.fieldType = .password
        return textField
    }()

    private let ageTextField: PBTextField = {
        let textField = PBTextField()
        textField.fieldType = .age
        return textField
    }()

    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        if let nextButtonColor = UIColor(named: "NextButtonColor") {
            button.backgroundColor = nextButtonColor
        } else {
            button.backgroundColor = .black
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Variables
    
    private var registrationViewModel: RegistrationViewModel!
    weak var coordinator: AuthorizationCoordinatorProtocol?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservables()
        configureViewModel()
    }
    
    // MARK: - ViewModel Configuration
    
    private func configureViewModel() {
        let registrationRepository = RegistrationRepository()
        registrationViewModel = RegistrationViewModel(registrationRepository: registrationRepository, coordinator: coordinator)
    }

    // MARK: - UI Configuration
    
    private func setupUI() {
        if let accentColor = UIColor(named: "AccentColor") {
            view.backgroundColor = accentColor
        } else {
            view.backgroundColor = .systemOrange
        }

        view.addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(ageTextField)
        stackView.addArrangedSubview(registerButton)
        
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    // MARK: - Observables
    
    private func setupObservables() {
        let registerAction = UIAction {[weak self] _ in
            self?.onRegisterClicked()
        }
        
        registerButton.addAction(registerAction, for: .touchUpInside)
    }
    
    // MARK: - Button Click Handler
    
    private func onRegisterClicked() {
        showLoader()
        registrationViewModel.registerUser(email: emailTextField.text, password: passwordTextField.text, age: ageTextField.text) {[weak self] result in
            DispatchQueue.main.async {
                self?.hideLoader()
                switch result {
                case .success:
                    break
                case .failure(let error):
                    self?.handleRegistrationError(error)
                }
            }
        }
    }
    
    // MARK: - Error Handling
    
    private func handleRegistrationError(_ error: RegistrationError) {
        var errorMessage: String
        
        switch error {
        case .invalidInput:
            errorMessage = "Please provide valid email and password."
        case .invalidEmail:
            errorMessage = "Please provide a valid email."
        case .invalidPassword:
            errorMessage = "Please provide a valid password."
        case .invalidAge:
            errorMessage = "Please provide a valid age."
        case .registrationFailed:
            errorMessage = "Registration failed. Please check your credentials and try again."
        }
        showAlert(title: "Error", message: errorMessage)
    }
    
}
