//
//  PostViewController.swift
//  Navigation
//
//  Created by M M on 3/20/22.
//

import Foundation
import UIKit

final class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc func newInfoViewController() {
        let newInfoViewController = InfoViewController()
        newInfoViewController.title = "Info"
        self.navigationController?.pushViewController(newInfoViewController, animated: true)
    }

    private func setupView() {
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .systemBlue
        let infoBarButtonItem = UIBarButtonItem(title: "News", style: .plain, target: self, action: #selector(self.newInfoViewController))
        self.navigationItem.rightBarButtonItem = infoBarButtonItem
    }
}
