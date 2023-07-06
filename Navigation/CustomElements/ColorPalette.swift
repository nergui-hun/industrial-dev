//
//  Palette.swift
//  Navigation
//
//  Created by M M on 7/7/23.
//

import Foundation
import UIKit

struct ColorPalette {
    static let mainBackgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
    static let label = UIColor.createColor(lightMode: .white, darkMode: .systemGray5)
    static let textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
    static let border = UIColor.createColor(lightMode: .darkGray, darkMode: .white)
    static let tableViewCellColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray6)
    static let loginBackgroundColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray6)
}
