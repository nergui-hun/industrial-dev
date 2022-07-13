//
//  PostViewController.swift
//  Navigation
//
//  Created by M M on 3/20/22.
//

import Foundation
import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        print("post")
    }

    @objc func newInfoViewController() {
        let newInfoViewController = InfoViewController()
        newInfoViewController.title = "Info"
        self.navigationController?.pushViewController(newInfoViewController, animated: true)
    }

    private func setupView() {
        
        view.backgroundColor = .white
        let infoBarButtonItem = UIBarButtonItem(title: "News", style: .plain, target: self, action: #selector(self.newInfoViewController))
        self.navigationItem.rightBarButtonItem = infoBarButtonItem
    }
}
