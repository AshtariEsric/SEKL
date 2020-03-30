//
//  RegistrationScreen.swift
//  EKL
//
//  Created by Dennis Hasselbusch on 10.09.19.
//  Copyright © 2019 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct RegistrationScreen : View {
    @State private var password : String = ""
    @State private var email : String = ""
    @State private var uuid = UUID().uuidString
    @State private var error : String = ""
    @State private var errorMeldung : Bool = false
    @State private var errorMeldungMail : Bool = false
    @EnvironmentObject var session: SessionStore
    
    
    ////WORK
    func signUp(){
        session.signUp(email: email, password: password){
            (result, error) in
            if let error = error {
                if self.password.count < 6 {
                    self.errorMeldung = true
                    self.error = error.localizedDescription
                } else {
                    self.error = error.localizedDescription
                    self.errorMeldungMail = true
                }
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Form{
                Section(header: Text("Userinformationen"))
                    {
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: signUp){
                            Text("Registration!")
                            
                        }.alert(isPresented: $errorMeldung){
                            Alert(title: Text("Error!"), message: Text("Passwort muss mehr als 6 Ziffern haben"), dismissButton: .default(Text("Ok")))
                        }
                        .alert(isPresented: $errorMeldungMail){
                            Alert(title: Text("Error!"), message: Text("Die Email Adresse ist nicht korrekt"), dismissButton: .default(Text("Ok")))
                        }
                        
                        .frame(width: 150, height: 50, alignment: .center)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .background(Color.blue)
                }
                }.navigationBarTitle("Registration", displayMode: .inline)
            }
        }
    }
}

#if DEBUG
struct RegistrationScreen_Previews : PreviewProvider {
    static var previews: some View {
        RegistrationScreen()
    }
}
#endif
