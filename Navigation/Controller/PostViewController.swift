//
//  PostViewController.swift
//  Navigation
//
//  Created by M M on 3/20/22.
//

import Foundation
import UIKit

final class PostViewController: UIViewController {

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc func redirectInfo() {
        let infoVC = InfoViewController()
        infoVC.title = "Info"
        self.navigationController?.pushViewController(infoVC, animated: true)
    }

    private func setupView() {
        
        view.backgroundColor = .white
        let infoBarButtonItem = UIBarButtonItem(title: "News", style: .plain, target: self, action: #selector(self.redirectInfo))
        self.navigationItem.rightBarButtonItem = infoBarButtonItem
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .systemBlue
    }
}
