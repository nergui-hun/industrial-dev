//
//  CustomTextField.swift
//  Navigation
//
//  Created by M M on 7/27/22.
//

import Foundation
import UIKit

final class CustomTextField: UITextField {

    private let editText: () -> Void

    init(editText: @escaping() -> Void) {
        self.editText = editText
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(inputText), for: .editingChanged)
        self.backgroundColor = .white
        self.placeholder = "Password"
        self.text = ""
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func inputText() {
        self.editText()
        Word.shared.compareString = self.text ?? ""
    }

}
