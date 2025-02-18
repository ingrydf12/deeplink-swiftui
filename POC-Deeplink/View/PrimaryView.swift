//
//  PrimaryView.swift
//  POC-Deeplink
//
//  Created by Ingryd Cordeiro Duarte on 18/02/25.
//

import SwiftUI

struct PrimaryView: View {
    var myService = ServiceCall()
    @State private var email = ""

    var body: some View {
        VStack {
            Text("Esse é um teste de deeplinks")
                .bold()
                .padding()

            TextField("Digite seu e-mail", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                if !email.isEmpty {
                    myService.forgotPassword(email: email) { result in
                        switch result {
                        case .success():
                            print("Email enviado com sucesso!")
                        case .failure(let error):
                            print("Erro ao enviar email: \(error.localizedDescription)")
                        }
                    }
                }
            }) {
                Text("Esqueci minha senha")
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    PrimaryView()
}
