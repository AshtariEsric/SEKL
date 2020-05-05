//
//  RegistrationScreen.swift
//  EKL
//
//  Created by Dennis Hasselbusch on 10.09.19.
//  Copyright © 2019 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

enum alertChoice {
    //first: Password is too short
    case first
    //second: email format is incorrect
    case second
    //third: everything is fine
    case third
}

struct RegistrationScreen : View {
    @State private var password : String = ""
    @State private var email : String = ""
    @State private var uuid = UUID().uuidString
    @State private var error : String = ""
    @State private var errorMeldung : Bool = false
    //@State private var errorMeldungMail : Bool = false
    @State private var alertChoice : alertChoice = .first
    @EnvironmentObject var session: SessionStore
    
    
    func signUp(){
        session.signUp(email: email, password: password){
            (result, error) in
            if let error = error {
                if self.password.count < 6 {
                    self.alertChoice = .first
                    self.errorMeldung = true
                } else {
                    self.alertChoice = .second
                    self.errorMeldung = true
                }
                self.error = error.localizedDescription
                print(self.errorMeldung)
            } else {
                self.errorMeldung = true
                self.alertChoice = .third
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {   
        //NavigationView {
        ZStack{
            Image("Background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                Text("Email")
                    .font(.headline)
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Passwort")
                    .font(.headline)
                SecureField("Passwort", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                Button(action: signUp){
                    Text("Registrieren!")
                    
                }.alert(isPresented: $errorMeldung){
                    switch alertChoice {
                    case .first:
                        return Alert(title: Text("Error!"), message: Text("Passwort muss mehr als 6 Ziffern haben"), dismissButton: .default(Text("Ok")))
                    case .second:
                        return Alert(title: Text("Error!"), message: Text("Die Email Adresse ist nicht korrekt. Nutze folgendes Format: Text@provider.de"), dismissButton: .default(Text("Ok")))
                    case .third:
                        return Alert(title: Text("Finish!"), message: Text("Du bist jetzt registriert. Bitte logge dich ein!"), dismissButton: .default(Text("Ok")))
                    }
                }
            }.navigationBarTitle("Registration", displayMode: .inline)
                .padding()
        }
    }
}
//}
#if DEBUG
struct RegistrationScreen_Previews : PreviewProvider {
    static var previews: some View {
        RegistrationScreen()
    }
}
#endif
