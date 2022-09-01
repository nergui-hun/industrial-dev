//
//  CustomButton.swift
//  Navigation
//
//  Created by M M on 7/27/22.
//
import Foundation
import UIKit

final class CustomButton: UIButton {

    private var action: () -> Void

    init(title: String, titleColor: UIColor, action: @escaping() -> Void) {
        self.action = action
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonTapped() {
        self.action()
    }
}
