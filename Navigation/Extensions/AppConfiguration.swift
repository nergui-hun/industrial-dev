//
//  AppConfiguration.swift
//  Navigation
//
//  Created by M M on 8/28/22.
//

import Foundation


enum AppConfiguration {
    case people(String)
    case starships(String)
    case planets(String)

    static func random() -> AppConfiguration {
        var generator = SystemRandomNumberGenerator()

        let index = Int.random(in: 1...3, using: &generator)
        let id = Int.random(in: 1...100, using: &generator)

        switch index {
        case 1:
            return AppConfiguration.people("https://swapi.dev/api/people/\(id)")
        case 2:
            return AppConfiguration.starships("https://swapi.dev/api/starships/\(id)")
        case 3:
            return AppConfiguration.planets("https://swapi.dev/api/planets/\(id)")
        default:
            return AppConfiguration.people("https://swapi.dev/api/people/\(id)")
        }
    }
}
