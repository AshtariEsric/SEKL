//
//  LoginFormView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 19.03.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct LoginFormView: View {
    @State private var initialUsername = "Test"
    @State private var initialPassword = "12345"
    
    @State private var name = String()
    @State private var pw = String()
    @State private var myAlertCredentials = false
    @State private var loginDisplay : String = "Login"
    @Binding var signInSuccess: Bool
    
       private var validate : Bool {
           !name.isEmpty && !pw.isEmpty
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
                           
                           VStack{
                               Text("Hello User.")
                                   .font(.largeTitle)
                               Text("Please insert your ")
                                   .font(.headline)
                                   .frame(width: 300, height: 20, alignment: .center)
                                   .lineLimit(nil)
                               Text("Username and your Password")
                                   .font(.headline)
                                   .frame(width: 300, height: 20, alignment: .center)
                                   .lineLimit(nil)
                           }.padding()
                           
                           //Text Username + Passwort
                           HStack{
                               Spacer()
                               Text("Username")
                                   .font(.headline)
                               Spacer()
                               Text("Password")
                                   .font(.headline)
                               Spacer()
                           }
                           
                           //TextField for insert name + password
                           HStack{
                               TextField("Fill your name", text: $name)
                                   .textFieldStyle(RoundedBorderTextFieldStyle())
                                   .scaledToFit()
                               Spacer()
                               SecureField("123456789", text:$pw)
                                   .scaledToFit()
                                   .textFieldStyle(RoundedBorderTextFieldStyle())
                               Spacer()
                           }
                           Spacer()
                           Spacer()
                           
                           //Login + Registration Button
                           ///TODO: Check if name + password is in database
                           Button(action: {
                            
                               if !self.name.isEmpty && !self.pw.isEmpty {
                                   self.loginDisplay = self.loginDisplay == "Login" ? "Logging in..." : "Login"
                                }
                            
                                if self.name == self.initialUsername && self.pw == self.initialPassword {
                                        self.signInSuccess = true
                                    } else {
                                        self.myAlertCredentials = true
                                        self.loginDisplay = "Login"
                                }
                           })
                           {
                                   Text(loginDisplay)
                                       .foregroundColor(.white)
                                       .font(.subheadline)
                                       .frame(width: 150, height: 50, alignment: .center)
                                       .clipped()
                                       .background(validate ? Color.green : Color.red)
                                       .cornerRadius(80)
                            }
                               .alert(isPresented: $myAlertCredentials) {
                                Alert(title: Text("Error!"), message: Text("Wrong Username or Password"), dismissButton: .default(Text("Ok")))
                            }

                           //NavigationLink to registration
                           NavigationLink(destination: RegistrationScreen())
                               {
                                  Text("Registrieren")
                                   .foregroundColor(.white)
                                   .font(.subheadline)
                                   .frame(width: 150, height: 50, alignment: .center)
                                   .background(Color.blue)
                                   .cornerRadius(80)
                               }

                               .frame(width: 200, alignment: .bottom)
                               
                           }
               }.navigationBarTitle("Willkommen!")
           }
       }
}

/*struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(signInSuccess: self.signInSuccess)
    }
}*/
