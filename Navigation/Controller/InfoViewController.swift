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

    lazy var alertButton: CustomButton = {
        let alertButton = CustomButton(title: "Post a photo", titleColor: .black, action: alertButtonAction)
        alertButton.backgroundColor = .yellow
        return alertButton
    } ()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }


    private func setupView() {
        view.backgroundColor = .black
        
        self.view.addSubview(alertButton)
        alertButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }

    @objc func alertButtonAction() {
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
