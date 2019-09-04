//
//  LoginViewModel.swift
//  CombineSample
//
//  Created by Maria Holubieva on 01.09.2019.
//  Copyright © 2019 Maria Holubieva. All rights reserved.
//

import Foundation
import Combine

enum LoginState {
    case signInDisabled
    case signInEnabled
    case signInStarted
}

class LoginViewModel: ObservableObject {

    @Published private(set) var loginState: LoginState = .signInDisabled {
        didSet {
            switch loginState {
            case .signInDisabled: break
            case .signInEnabled: break
            case .signInStarted: performSignInRequest()
            }
        }
    }

    var email: String = "" {
        didSet { checkIsSignInEnabled() }
    }
    var password: String = "" {
        didSet { checkIsSignInEnabled() }
    }

    private func checkIsSignInEnabled() {
        guard loginState != .signInStarted else { return }

        let isSingInEnabled = !email.isEmpty && !password.isEmpty
        if isSingInEnabled {
            loginState = .signInEnabled
        } else {
            loginState = .signInDisabled
        }
    }

    func performSignIn() {
        loginState = .signInStarted
    }

    private func performSignInRequest() {
        print("SIGN IN in progress...")
    }
}

