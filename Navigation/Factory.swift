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


final class MyLoginFactory: LoginFactory {
    func getLoginInspector() -> LoginInspector {
       LoginInspector()
    }
}
