//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by M M on 4/3/22.
//

import Foundation
import UIKit
import SnapKit

class ProfileHeaderView: UIView {

    //================================VIEW ELEMENTS===============================//
    /*
     1. private let statusLabel: UILabel    V
     2. private let statusTextField: UITextField
     3. private let avatarImageView: UIImageView    !!!!!!!!!resize
     4. private let fullNameLabel: UILabel  V
     5. private lazy var setStatusButton: UIButton
     6. lazy var alphaView: UIView
     7. private let closeButton: UIButton
     */
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Waiting for something..."
        return label
    }()

    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect()
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isHidden = true
        return textField
    }()

    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bald")
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = avatarImageViewSize / 2
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Bald Cat"
        label.numberOfLines = 0
        return label
    }()

    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.tintColor = .white
        button.setTitle("Show status", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    lazy var alphaView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let closePhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "x.square.fill"), for: .normal)
        button.backgroundColor = .red
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.tintColor = .white
        button.addTarget(ProfileHeaderView.self, action: #selector(zoomOutUserPhoto), for: .touchUpInside)
        button.isHidden = true
        button.alpha = 0
        return button
    }()

    //=============================GESTURES===================================//
    private lazy var tap: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(cancelEditing))
        tapGesture.cancelsTouchesInView = false
        return tapGesture
    }()

    //============================CONSTRAINTS=================================//
    private var statusButtonTopConstraint: Constraint? = nil
    let avatarImageViewSize: CGFloat = 130
    let spacing: CGFloat = 16

    //===========================INITIALIZERS=================================//
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //==========================METHODS==================================//
    /*
     1. private func setConstraints()
     2. private func addElements()
     3. @objc func buttonPressed(_ sender: UIButton!)
     4. func zoomInUserPhoto()
     5. @objc func zoomOutUserPhoto(vc: UIViewController)
     6. @objc func showClosePhotoButton()
     7. @objc func hideClosePhotoButton() 
     8. @objc func cancelEditing()
     */
    private func setConstraints() {
        let labelsLeftSpace = spacing + avatarImageViewSize

        avatarImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(spacing)
            make.size.equalTo(avatarImageViewSize)
        }

        fullNameLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(labelsLeftSpace)
            make.right.equalToSuperview().offset(-spacing)
            make.top.equalToSuperview().offset(27)
            make.height.equalTo(30)
        }

        statusLabel.snp.makeConstraints{ make in
            make.left.right.height.equalTo(fullNameLabel)
            make.top.equalTo(fullNameLabel).offset(82)
        }

        statusTextField.snp.makeConstraints{ make in
            make.left.right.height.equalTo(fullNameLabel)
            make.top.equalTo(statusLabel.snp.bottom).offset(5)
        }

        setStatusButton.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(spacing)
            self.statusButtonTopConstraint = make.top.equalTo(statusLabel.snp.bottom).offset(20).constraint
            make.height.equalTo(50)
            make.right.equalTo(fullNameLabel)
        }
    }

    private func addElements() {
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(fullNameLabel)
        self.addSubview(setStatusButton)
        self.addSubview(alphaView)
        self.addSubview(avatarImageView)
        avatarImageView.addSubview(closePhotoButton)
        self.addGestureRecognizer(tap)
    }
    

    @objc func buttonPressed(_ sender: UIButton!) {

        let statusButtonTitle: String = sender.currentTitle!
        if(statusButtonTitle == "Show status") {

            sender.setTitle("Set status", for: .normal)
            self.statusTextField.isHidden = false
            statusTextField.text = statusLabel.text
            self.statusButtonTopConstraint?.update(offset: 40)
            statusTextField.becomeFirstResponder()

        } else {
            statusLabel.text = statusTextField.text
            sender.setTitle("Show status", for: .normal)
            self.endEditing(true)
            self.setStatusButton.setTitle("Show status", for: .normal)
            statusButtonTopConstraint?.update(offset: 20)
            statusTextField.isHidden = true
        }
    }

    func setAlphaViewConstraints(vc: UIViewController) {
        alphaView.snp.makeConstraints{ make in
            make.left.right.equalTo(vc.view)
            make.top.equalTo(vc.view.snp.topMargin)
            make.bottom.equalTo(vc.view.snp.bottomMargin)
        }
    }

    func zoomInUserPhoto(vc: UIViewController) {
        let avatarImageViewSize = UIScreen.main.bounds.width > UIScreen.main.bounds.width ?
        UIScreen.main.bounds.height : UIScreen.main.bounds.width

        avatarImageView.snp.remakeConstraints{ make in
            make.center.equalTo(vc.view.snp.center)
            make.size.equalTo(avatarImageViewSize)
        }

        closePhotoButton.snp.makeConstraints{ make in
            make.right.top.equalTo(avatarImageView)
            make.height.width.equalTo(50)
        }

        alphaView.alpha = 0.8
        avatarImageView.layer.cornerRadius = 0
    }

    @objc func zoomOutUserPhoto(vc: UIViewController) {

        avatarImageView.snp.remakeConstraints{ make in
            make.left.top.equalToSuperview().offset(spacing)
            make.size.equalTo(avatarImageViewSize)
        }

        alphaView.alpha = 0
        avatarImageView.layer.cornerRadius = avatarImageViewSize / 2
        closePhotoButton.isHidden = true
    }

    @objc func showClosePhotoButton() {
        closePhotoButton.isHidden = false
        closePhotoButton.alpha = 1
    }

    @objc func hideClosePhotoButton() {
        closePhotoButton.alpha = 0
    }

    @objc func cancelEditing() {
        self.endEditing(true)
    }
}
