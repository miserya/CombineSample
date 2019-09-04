//
//  LoginSwiftUIView.swift
//  CombineSample
//
//  Created by Maria Holubieva on 01.09.2019.
//  Copyright © 2019 Maria Holubieva. All rights reserved.
//

import SwiftUI
import Combine

struct LoginSwiftUIView: View {

    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()

    var body: some View {
        VStack {
            Text("SwiftUI Login")
                .padding(.bottom, 70.0)
            TextField("email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                .disabled(viewModel.loginState == .signInStarted)
            SecureField("password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 70, trailing: 20))
                .disabled(viewModel.loginState == .signInStarted)
            Button(action: {
                self.viewModel.performSignIn()
                }, label: { Text("SignIn") })
                .disabled(viewModel.loginState != .signInEnabled)
        }
    }
}

struct LoginSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSwiftUIView()
    }
}
