//
//  Word.swift
//  Navigation
//
//  Created by M M on 7/27/22.
//

import Foundation

final class Word {
    static let shared = Word()
    private let password: String = "Pswd"
    private var notification: String = ""
    var compareString: String = ""


    func check() {
        let notify = NotificationCenter.default
        notification = compareString == password ? "PasswordCorrect" : "PasswordWrong"
        notify.post(name: Notification.Name(notification), object: nil)
    }
}
