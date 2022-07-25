//
//  Factory.swift
//  Navigation
//
//  Created by M M on 7/24/22.
//

import Foundation

protocol LoginFactory {
    func getLoginInspector() -> LoginInspector
}


class MyLoginFactory: LoginFactory {
    func getLoginInspector() -> LoginInspector {
        let inspector = LoginInspector()
        return inspector
    }
}
