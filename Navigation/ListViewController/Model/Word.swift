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
    var compareString: String = ""


    func check() {
        let notify = NotificationCenter.default
        notify.post(name: Notification.Name(compareString == password ?
                                            "PasswordCorrect" : "PasswordWrong"), object: nil)
    }
}
