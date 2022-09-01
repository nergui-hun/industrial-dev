//
//  LoginVM.swift
//  Navigation
//
//  Created by M M on 7/31/22.
//

import Foundation

final class LoginVM {

    enum Action {
        case viewReady
    }

    enum State {
        case initial
        case loaded
        case error
    }

    var stateChanged: ((State) -> Void)?

    private(set) var state: State = .initial {
        didSet {
            stateChanged?(state)
        }
    }

    func changeState(_ action: Action) {
        switch action {
        case .viewReady:
            state = .loaded
        }
    }
}
