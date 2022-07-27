//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by M M on 4/29/22.
//

import Foundation
import UIKit

final class ProfileTableHeaderView: UIViewController {

    let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        title = "Profile"
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1

        profileHeaderView.backgroundColor = UIColor.lightGray
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(profileHeaderView)
        profileHeaderView.layer.borderColor = UIColor.black.cgColor
        profileHeaderView.layer.borderWidth = 1

        NSLayoutConstraint.activate([
            profileHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            profileHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
