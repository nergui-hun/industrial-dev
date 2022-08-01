//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by M M on 4/29/22.
//

import Foundation
import UIKit

final class ProfileTableHeaderView: UIViewController {

    // MARK: - Values
    let profileHeaderView = ProfileHeaderView()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(profileHeaderView)
        profileHeaderView.pin(to: view)
    }
}
