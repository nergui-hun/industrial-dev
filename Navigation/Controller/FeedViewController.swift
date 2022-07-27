//
//  FeedViewController.swift
//  Navigation
//
//  Created by M M on 3/20/22.
//

import Foundation
import UIKit

final class FeedViewController: UIViewController {

    // MARK: - View Elements

    private lazy var postButton: CustomButton = {
        let button = CustomButton(title: "Post button", titleColor: .white) {
            let postVC = PostViewController()
            postVC.title = "Post button"
            self.navigationController?.pushViewController(postVC, animated: true)
        }

        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var anotherPostButton: CustomButton = {
        let button = CustomButton(title: "Another post button", titleColor: .white) {
            let postVC = PostViewController()
            self.navigationController?.pushViewController(postVC, animated: true)
            postVC.title = "Another post button"
        }

        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    var feedTextField: CustomTextField = {
        let textField = CustomTextField {}
        return textField
    } ()

    private lazy var checkPasswordButton: CustomCheckButton = {
        let button = CustomCheckButton {}
        return button
    } ()

    private let statusLabel: UILabel = {
        let label = UILabel()
        return label
    } ()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        let notify = NotificationCenter.default
        notify.addObserver(self, selector: #selector(getCorrectPassword), name: Notification.Name("PasswordCorrect"), object: nil)
        notify.addObserver(self, selector: #selector(getWrongPassword), name: Notification.Name("PasswordWrong"), object: nil)
    }
    
    func setupView() {
        title = "Feed"
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        self.navigationController?.navigationBar.isHidden = true

        stackView.addArrangedSubview(postButton)
        stackView.addArrangedSubview(anotherPostButton)
        stackView.addArrangedSubview(feedTextField)
        stackView.addArrangedSubview(checkPasswordButton)
        stackView.addArrangedSubview(statusLabel)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            postButton.heightAnchor.constraint(equalToConstant: 50),
            anotherPostButton.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    @objc func getCorrectPassword() {
        statusLabel.text = "The password is correct!"
        statusLabel.textColor = .systemGreen
    }

    @objc func getWrongPassword() {
        statusLabel.text = "The password is wrong"
        statusLabel.textColor = .systemRed
    }
}
