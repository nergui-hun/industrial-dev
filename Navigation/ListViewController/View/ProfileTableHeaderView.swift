//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by M M on 4/29/22.
//

import Foundation
import UIKit

final class ProfileTableHeaderView: UIViewController {

    // MARK: - View Elements
    let profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.backgroundColor = UIColor.lightGray
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        title = "Profile"
        //view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1

        view.addSubview(profileHeaderView)
        profileHeaderView.pin(to: view)
    }
}
