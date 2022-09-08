//
//  Planet.swift
//  Navigation
//
//  Created by M M on 9/8/22.
//

import Foundation
import CoreText

enum ClimateType: String {
    case arid = "arid"
    case humid = "humid"
}

enum GravityType: String {
    case firstStandard = "1 standard"
    case secondStandard = "2 standard"
}

enum TerrainType: String {
    case desert = "desert"
    case field = "field"
}

struct Planet: Decodable {
    let name: String
    let rotationPeriod: Int
    let orbitalPeriod: String
    let diameter: Int
    var climate: String
    let gravity: String
    var terrain: String
    var surfaceWater: Int
    var population: Int
    var residents: [String]
    var films: [String]
    let created: String
    var edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case population
        case residents
        case films
        case created
        case edited
        case url
}


}
