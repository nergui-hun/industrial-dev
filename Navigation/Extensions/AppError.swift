//
//  Error.swift
//  Navigation
//
//  Created by M M on 8/6/22.
//

import Foundation

enum AppError: Error {
 case unauthorized
    case notFound
    case invalidModel
    case internalServer
}

func handle(error: AppError) {
    switch error {
    case .unauthorized:
        print("We have some problems with authorization token")
    case .notFound, .internalServer:
        print("We have some problems with our server")
    case .invalidModel:
        print("We have some problems with data parsing")
    }
}
