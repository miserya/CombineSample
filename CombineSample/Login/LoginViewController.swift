//
//  LoginViewController.swift
//  CombineSample
//
//  Created by Maria Holubieva on 26.08.2019.
//  Copyright © 2019 Maria Holubieva. All rights reserved.
//

import UIKit
import Combine

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!

    private var emailPublisher: AnyCancellable?
    private var emailEditablePublisher: AnyCancellable?
    private var passwordPublisher: AnyCancellable?
    private var passwordEditablePublisher: AnyCancellable?
    private var btnSignInEnabledPublisher: AnyCancellable?

    private lazy var viewModel: LoginViewModel = {
        return LoginViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldEmail.delegate = self
        textFieldPassword.delegate = self

        btnSignIn.isEnabled = false

        emailPublisher = textFieldEmail
            .publisher(for: \.text)
            .assign(to: \.email, on: viewModel)

        emailEditablePublisher = viewModel.$loginState
            .map({ return $0 != .signInStarted })
            .assign(to: \.isEnabled, on: textFieldEmail)

        passwordPublisher = textFieldPassword
            .publisher(for: \.text)
            .assign(to: \.password, on: viewModel)

        passwordEditablePublisher = viewModel.$loginState
            .map({ return $0 != .signInStarted })
            .assign(to: \.isEnabled, on: textFieldPassword)

        btnSignInEnabledPublisher = viewModel.$loginState
            .map({ return $0 == .signInEnabled })
            .assign(to: \.isEnabled, on: btnSignIn)
    }

    @IBAction func onSignIn(_ sender: Any) {
        viewModel.performSignIn()
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textFieldEmail:    textFieldPassword.becomeFirstResponder()
        case textFieldPassword: textFieldPassword.resignFirstResponder()
        default:                break
        }
        return false
    }
}

