//
//  LogInViewController.swift
//  Navigation
//
//  Created by M M on 4/25/22.
//

import Foundation
import UIKit
import FirebaseAuth
import SnapKit

final class LogInViewController: UIViewController {

    // MARK: - Values

<<<<<<< Updated upstream
=======
    private let coordinator: LoginCoordinator
    let viewModel: LoginVM
>>>>>>> Stashed changes
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    private weak var loginDelegate: LoginViewControllerDelegate?

    // MARK: - View Elements

    let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .red
        return label
    } ()

    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    } ()

    private lazy var emailPhoneTextField: UITextField = {
        let textField = UITextField()
        setupTextFields(textField)
        textField.placeholder = "Email or phone"
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return textField
    } ()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        setupTextFields(textField)
        textField.placeholder = "Password"
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.isSecureTextEntry = true
        return textField
    } ()

<<<<<<< Updated upstream
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel.png"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10

        if button.isSelected || button.isHighlighted || !button.isEnabled{
            button.alpha = 0.8
        } else {
            button.alpha = 1
        }

        button.addTarget(self, action: #selector(redirectProfile), for: .touchUpInside)
=======
    private lazy var logInButton: CustomButton = {
        let button = CustomButton(title: "Log In", titleColor: .white) {
            self.logIn()
        }
        button.setBackgroundImage(UIImage(named: "blue_pixel.png"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.isEnabled = false
>>>>>>> Stashed changes
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var contentView: UIView = {
        let content = UIView()
        content.frame.size = contentViewSize
        return content
    } ()

    let logInTextFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
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


<<<<<<< Updated upstream
=======
    // MARK: - init

    init(coordinator: LoginCoordinator, viewModel: LoginVM) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        loginDelegate = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

>>>>>>> Stashed changes
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }

    private func logIn() {
        if let email = self.emailPhoneTextField.text, let pass = self.passwordTextField.text {
            if let loginDelegate = loginDelegate {
                loginDelegate.checkCredentials(email: email, pass: pass, vc: self)
            }
        } else {
            print("\n\n\n\nerror\n\n\n\n")
        }
    }

    func textChanged() {
        if self.emailPhoneTextField.hasText && self.passwordTextField.hasText {
            logInButton.isEnabled = true
        } else {
            logInButton.isEnabled = false
        }

        if logInButton.isSelected || logInButton.isHighlighted {
            logInButton.alpha = 0.8
        } else {
            logInButton.alpha = 1
        }
    }



    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createKbdObservers()
        createLoginObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKbdObservers()
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
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
    }

<<<<<<< Updated upstream
    @objc func redirectProfile() {
        let profileViewController = ProfileViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        self.tabBarController?.viewControllers?[1] = profileNavigationController
        profileNavigationController.tabBarItem.image = UIImage(systemName: "person.fill")
    }

=======
>>>>>>> Stashed changes
    @objc func cancelEditing() {
        emailPhoneTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

<<<<<<< Updated upstream
=======
    private func setupViewModel() {
        viewModel.stateChanged = { [weak self] state in
            switch state {
            case .initial:
                ()
            case .loaded:
                self!.coordinator.redirectProfile(vc: ProfileViewController(), navCon: self!.navigationController, coordinator: self!.coordinator)
            case .error:
                ()
            }
        }
    }

>>>>>>> Stashed changes

    private func setupView() {
        title = "Profile"
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5

        view.addSubview(logoImage)
        logInTextFieldsStackView.addArrangedSubview(emailPhoneTextField)
        logInTextFieldsStackView.addArrangedSubview(passwordTextField)

        contentView.addSubview(logInTextFieldsStackView)
        logInTextFieldsScrollView.addSubview(contentView)
        view.addSubview(logInTextFieldsScrollView)
        view.addSubview(logInButton)
        view.addSubview(errorLabel)

        view.addGestureRecognizer(tap)
    }

    private func setConstraints() {

        logoImage.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide.snp.top).offset(120)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
        }

        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(90)
            make.leftMargin.rightMargin.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

        logInTextFieldsStackView.snp.makeConstraints { make in
            make.topMargin.equalTo(logoImage.snp.bottomMargin).offset(120)
            make.rightMargin.leftMargin.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }

        logInButton.snp.makeConstraints { make in
            make.topMargin.equalTo(logInTextFieldsStackView.snp.bottomMargin).offset(16)
            make.rightMargin.leftMargin.equalTo(errorLabel)
            make.height.equalTo(50)
        }
    }

    private lazy var tap: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(cancelEditing))
        tapGesture.cancelsTouchesInView = false
        return tapGesture
    }()

    // MARK: - Observers

    private func createLoginObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(enableLoginButton), name:
                                                UITextField.textDidChangeNotification, object: nil)
    }

    private func removeLoginObservers() {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
    }

    private func createKbdObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeKbdObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func enableLoginButton() {
        if emailPhoneTextField.hasText && passwordTextField.hasText {
            logInButton.isEnabled = true
        } else {
            logInButton.isEnabled = false
        }
    }

    @objc func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            logInTextFieldsScrollView.contentInset.bottom = kbdSize.height
            logInTextFieldsScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }

    @objc func kbdHide(notification: NSNotification) {
        logInTextFieldsScrollView.contentInset.bottom = .zero
        logInTextFieldsScrollView.verticalScrollIndicatorInsets = .zero
    }

}
