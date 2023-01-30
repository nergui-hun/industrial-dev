//
//  RegisterViewController.swift
//  Navigation
//
//  Created by M M on 10/8/22.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth

final class RegisterViewController: UIViewController {

    // MARK: - Values
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)

    // MARK: - View Elements
    private lazy var firstName: UITextField = {
        let textField = UITextField()
        setupTextFields(textField)
        textField.placeholder = "First name"
        return textField
    } ()

    private lazy var lastName: UITextField = {
        let textField = UITextField()
        setupTextFields(textField)
        textField.placeholder = "Last name"
        return textField
    } ()

    private lazy var emailPhoneTextField: UITextField = {
        let textField = UITextField()
        setupTextFields(textField)
        textField.placeholder = "Email or phone"
        return textField
    } ()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        setupTextFields(textField)
        textField.placeholder = "Password"
        return textField
    } ()

    lazy var contentView: UIView = {
        let content = UIView()
        content.frame.size = contentViewSize
        return content
    } ()

    private let logInTextFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var logInTextFieldsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = contentViewSize
        scrollView.frame = self.view.bounds
        return scrollView
    } ()

    private lazy var registerButton: CustomButton = {
        let button = CustomButton(title: "Register", titleColor: .systemBlue) {
            self.createUser(email: self.emailPhoneTextField.text!, password: self.passwordTextField.text!)
            }
        button.clipsToBounds = true
        button.layer.cornerRadius = 10

        if button.isSelected || button.isHighlighted
            || !button.isEnabled {
            button.alpha = 0.8
        } else {
            button.alpha = 1
            }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()


    // MARK: - init

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }

    private func setupView() {
        title = "New user"
        view.backgroundColor = .white
        //self.navigationController?.navigationBar.isHidden = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        logInTextFieldsStackView.addArrangedSubview(firstName)
        logInTextFieldsStackView.addArrangedSubview(lastName)
        logInTextFieldsStackView.addArrangedSubview(emailPhoneTextField)
        logInTextFieldsStackView.addArrangedSubview(passwordTextField)

        contentView.addSubview(logInTextFieldsStackView)
        logInTextFieldsScrollView.addSubview(contentView)
        view.addSubview(logInTextFieldsScrollView)
        view.addSubview(registerButton)
    }

    private func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                print(error!.localizedDescription.description)
                return
            }
            let loginCoordinator = LoginCoordinator()
            let loginVM = LoginVM()
            let controller = LogInViewController(coordinator: loginCoordinator, viewModel: loginVM)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            logInTextFieldsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logInTextFieldsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInTextFieldsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            logInTextFieldsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            logInTextFieldsStackView.heightAnchor.constraint(equalToConstant: 250),

            registerButton.topAnchor.constraint(equalTo: logInTextFieldsStackView.bottomAnchor, constant: 16),
            registerButton.leftAnchor.constraint(equalTo: logInTextFieldsStackView.leftAnchor),
            registerButton.rightAnchor.constraint(equalTo: logInTextFieldsStackView.rightAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupTextFields(_ textField: UITextField, _ cornerRadius: CGFloat = 10) {
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = cornerRadius
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Observers

    // MARK: - Extensions
}
