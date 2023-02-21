//
//  LogInViewController.swift
//  Navigation
//
//  Created by M M on 4/25/22.
//

import Foundation
import UIKit
import RealmSwift

final class LogInViewController: UIViewController {

    // MARK: - Values
    private let service = RealmService()
    private let coordinator: LoginCoordinator
    private let viewModel: LoginVM
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    let signupVC: SignupViewController

    // MARK: - View Elements

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

    private lazy var logInButton: CustomButton = {
        let button = CustomButton(title: "Log in", titleColor: .white) {
            self.login()
        }
        button.setBackgroundImage(UIImage(named: "blue_pixel.png"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10

        if button.isSelected || button.isHighlighted || !button.isEnabled {
            button.alpha = 0.8
        } else {
            button.alpha = 1
        }

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var signupButton: CustomButton  = {
        let button = CustomButton(title: "Sign up", titleColor: .white) {
            if let username = self.emailPhoneTextField.text,
               let password = self.passwordTextField.text {
                self.navigationController?.pushViewController(self.signupVC, animated: true)
            }
        }
        button.backgroundColor = .systemGreen
        button.clipsToBounds = true
        button.layer.cornerRadius = 10

        if button.isSelected || button.isHighlighted || !button.isEnabled {
            button.alpha = 0.8
        } else {
            button.alpha = 1
        }

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()

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


    // MARK: - init

    init(coordinator: LoginCoordinator, viewModel: LoginVM) {
        self.coordinator = coordinator
        self.signupVC = SignupViewController(coordinator: coordinator)
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
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

    @objc func login() {
        if let email = emailPhoneTextField.text,
           let password = passwordTextField.text {
            if service.login(email: email, password: password) == true {
                coordinator.openProfile()
            } else {
                print("nil")
            }
        }
    }

    @objc func cancelEditing() {
        emailPhoneTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    private func setupViewModel() {
        viewModel.stateChanged = { [weak self] state in
            switch state {
            case .initial:
                ()
            case .loaded:
                self!.coordinator.redirectProfile(navCon: self!.navigationController, coordinator: self!.coordinator)
            case .error:
                ()
            }
        }
    }


    private func setupView() {
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
        view.addSubview(signupButton)

        view.addGestureRecognizer(tap)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 120),

            logInTextFieldsStackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            logInTextFieldsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            logInTextFieldsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            logInTextFieldsStackView.heightAnchor.constraint(equalToConstant: 100),

            logInButton.topAnchor.constraint(equalTo: logInTextFieldsStackView.bottomAnchor, constant: 16),
            logInButton.leftAnchor.constraint(equalTo: logInTextFieldsStackView.leftAnchor),
            logInButton.rightAnchor.constraint(equalTo: logInTextFieldsStackView.rightAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),

            signupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            signupButton.leftAnchor.constraint(equalTo: logInButton.leftAnchor),
            signupButton.rightAnchor.constraint(equalTo: logInButton.rightAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private lazy var tap: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(cancelEditing))
        tapGesture.cancelsTouchesInView = false
        return tapGesture
    }()

    // MARK: - Observers

    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
