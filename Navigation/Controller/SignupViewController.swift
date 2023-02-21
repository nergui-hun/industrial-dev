//
//  SignupViewController.swift
//  Navigation
//
//  Created by M M on 2/11/23.
//

import Foundation
import UIKit
import SnapKit

final class SignupViewController: UIViewController {
    // MARK: - Values
    let service = RealmService()
    private let coordinator: LoginCoordinator

    // MARK: - View Elements
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        setupTextFields(textField)
        //textField.addTarget(self, action: #selector(showSignupButton), for: .editingChanged)
        return textField
    } ()

    private lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last name"
        setupTextFields(textField)
        //textField.addTarget(self, action: #selector(showSignupButton), for: .editingChanged)
        return textField
    } ()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        setupTextFields(textField)
        //textField.addTarget(self, action: #selector(showSignupButton), for: .editingChanged)
        return textField
    } ()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        setupTextFields(textField)
        textField.textContentType = .oneTimeCode
        textField.isSecureTextEntry = true
        //textField.addTarget(self, action: #selector(showSignupButton), for: .editingChanged)
        return textField
    } ()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .systemRed
        return label
    } ()

    private lazy var signupButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.setTitle("Sign up", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        //button.isHidden = true
        button.addTarget(self, action: #selector(signup), for: .touchUpInside)
        return button
    } ()

    // MARK: - init

    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc func signup() {
        if let email = emailTextField.text,
           let password = passwordTextField.text,
           let name = nameTextField.text,
           let lastName = lastNameTextField.text {
            self.service.signup(email: email, password: password, name: name, lastname: lastName)
            self.coordinator.openLoginVC()
        }
    }

    private func setupView() {
        view.backgroundColor = .white
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        view.addSubview(stackView)
        view.addSubview(signupButton)

        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.height.equalTo(248)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }

        lastNameTextField.snp.makeConstraints { make in
            make.left.right.height.equalTo(nameTextField)
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
        }

        emailTextField.snp.makeConstraints { make in
            make.left.right.height.equalTo(nameTextField)
            make.top.equalTo(lastNameTextField.snp.bottom).offset(16)
        }

        passwordTextField.snp.makeConstraints { make in
            make.left.right.height.equalTo(nameTextField)
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
        }

        signupButton.snp.makeConstraints { make in
            make.left.right.equalTo(stackView)
            make.height.equalTo(50)
            make.top.equalTo(stackView.snp.bottom).offset(50)
        }
    }

    private func setupTextFields(_ textField: UITextField) {
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc private func showSignupButton() {
        if nameTextField.hasText && lastNameTextField.hasText
            && emailTextField.hasText && passwordTextField.hasText {
            signupButton.isHidden = false
        } else {
            signupButton.isHidden = true
        }
    }

    // MARK: - Observers

    // MARK: - Extensions
}
