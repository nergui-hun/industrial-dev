//
//  InfoViewController.swift
//  Navigation
//
//  Created by M M on 3/23/22.
//

import Foundation
import UIKit
import SnapKit

final class InfoViewController: UIViewController {

    // MARK: - View Elements

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        //stackView
        return stackView
    } ()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        return label
    } ()

    let alertButton: UIButton = {
        let alertButton = UIButton(type: .system)
        alertButton.backgroundColor = .yellow
        alertButton.setTitle("Post a photo", for: .normal)
        alertButton.tintColor = .black
        alertButton.addTarget(self, action: #selector(alertButtonAction), for: .touchUpInside)
        return alertButton
    } ()


    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
    }

    private func setupElements() {
        view.backgroundColor = .black
        view.addSubview(stackView)
        stackView.addArrangedSubview(alertButton)
        stackView.addArrangedSubview(titleLabel)


        alertButton.frame.size = CGSize(width: 150, height: 50)

        stackView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            //make.
        }

        titleLabel.text = NetworkManager.title
    }

    @objc func alertButtonAction(_ sender: UIButton!) {
        let myAlertController = UIAlertController(title: "Think twice!", message: "Do you really want everyone to see how ugly you are?", preferredStyle: .alert)

        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .default) { (action) -> Void in
            print("Cancelled")
        }
        let okAlertAction = UIAlertAction(title: "Post", style: .default) { (action) -> Void in
            print("Posted")
        }
        myAlertController.addAction(cancelAlertAction)
        myAlertController.addAction(okAlertAction)

        self.present(myAlertController, animated: true, completion: nil)
    }
}
