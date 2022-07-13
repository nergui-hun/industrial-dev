//
//  InfoViewController.swift
//  Navigation
//
//  Created by M M on 3/23/22.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        let alertButton = UIButton(type: .system)
        alertButton.frame.size = CGSize(width: 150, height: 50)
        alertButton.backgroundColor = .yellow
        alertButton.setTitle("Post a photo", for: .normal)
        alertButton.center = view.center
        alertButton.tintColor = .black
        alertButton.addTarget(self, action: #selector(self.alertButtonAction), for: .touchUpInside)
        alertButton.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin]
        self.view.addSubview(alertButton)
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
