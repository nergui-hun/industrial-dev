//
//  CustomCheckButton.swift
//  Navigation
//
//  Created by M M on 7/27/22.
//

import Foundation
import UIKit

final class CustomCheckButton: UIButton {

    private var action: () -> Void

    init(action: @escaping() -> Void) {
        self.action = action
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(checkPassword), for: .touchUpInside)
        self.backgroundColor = .systemBlue
        self.setTitle("Check Password", for: .normal)
        self.setTitleColor(.white, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func checkPassword() {
        self.action()
        if !Word.shared.compareString.isEmpty {
            Word.shared.check()
        }
    }

}
