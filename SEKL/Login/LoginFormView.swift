//
//  LoginFormView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 19.03.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct LoginFormView: View {
    @State private var myAlertCredentials = false
    @State private var loginDisplay : String = "Login"
    @Binding var signInSuccess: Bool
    
    private var validate : Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    @State private var password : String = ""
    @State private var email : String = ""
    @State private var uuid = UUID().uuidString
    @State private var error : String = ""
    
    @EnvironmentObject var session: SessionStore
    
    func signIn(){
        session.signIn(email: email, password: password){ (result, error) in
            if let error = error {
                self.error = error.localizedDescription
                self.myAlertCredentials = true
            } else {
                self.email = ""
                self.password = ""
                self.signInSuccess = true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Image("Background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Spacer()
                    Spacer()
                    //Text Username + Passwort
                    HStack(alignment: .center){
                        Spacer()
                        Text("Username")
                            .font(.headline)
                        Spacer()
                        Spacer()
                        Text("Password")
                            .font(.headline)
                        Spacer()
                    }
                    //TextField for insert name + password
                    HStack{
                        TextField("Fill your name", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .scaledToFit()
                        Spacer()
                        SecureField("123456789", text:$password)
                            .scaledToFit()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer()
                    }
                    Spacer()
                    Spacer()
                    //Login Button with signIn Function
                    Button(action: signIn)
                    {
                        Text(loginDisplay)
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(width: 150, height: 50, alignment: .center)
                            .clipped()
                            .background(validate ? Color.green : Color.red)
                            .cornerRadius(80)
                    }
                    .alert(isPresented: $myAlertCredentials) {
                        Alert(title: Text("Error!"), message: Text("Wrong Username or Password"), dismissButton: .default(Text("Ok")))
                    }
                    
                    //NavigationLink for registration
                    NavigationLink(destination: RegistrationScreen())
                    {
                        HStack{
                            Text("Ich bin neu hier - ")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.primary)
                            Text("Registrieren!")
                                .font(.system(size:14, weight: .semibold))
                                .foregroundColor(Color.blue)
                        }
                    }
                    
                }
            }.navigationBarTitle("Willkommen!")
        }
    }
}


struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
