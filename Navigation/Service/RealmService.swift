//
//  RealmService.swift
//  Navigation
//
//  Created by M M on 1/31/23.
//

import Foundation
import RealmSwift

protocol RealmServiceDelegate: AnyObject {
    func signup(email: String, password: String, name: String, lastname: String)
    func login(email: String, password: String) -> Bool
}

final class RealmService: RealmServiceDelegate {


    let realm = try! Realm()

    func signup(email: String, password: String, name: String, lastname: String) {

        print("email is: \(email)")
        let userData = UserData()
        userData.email = email
        userData.password = password
        userData.name = name
        userData.lastname = lastname

        try! realm.write({
            realm.add(userData)
        })
        print(realm.configuration.fileURL)
    }

    func login(email: String, password: String) -> Bool {
        //let users: Results<UserData>? = realm.objects(UserData.self)

        if let user = realm.object(ofType: UserData.self, forPrimaryKey: email) {
            if user.password == password {
                UserDefaults.standard.set(true, forKey: "loginMatch")
                return true
            }
        }
        return false
    }

    func getData() {

    }
}
