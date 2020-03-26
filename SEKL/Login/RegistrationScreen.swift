//
//  RegistrationScreen.swift
//  EKL
//
//  Created by Dennis Hasselbusch on 10.09.19.
//  Copyright © 2019 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct RegistrationScreen : View {
    @State private var myName : String = ""
    @State private var myAge : String = ""
    @State private var myPassword : String = ""
    @State private var email : String = ""
    @State private var uuid = UUID().uuidString
    
    func writeDB(_ uuid: String, _ myName: String, _ myAge : String, _ myPassword: String){
        print("\(self.uuid) wird als ID gespeichert, \(self.myName) wird als Name gespeichert, \(self.myAge) wird als alter gespeichert und dein Password ist \(self.myPassword)")
    }
    
    
    var body: some View {
        NavigationView {
            ZStack{
                Form{
                Section(header: Text("Userinformationen"))
                    {
                        TextField("Nickname", text: $myName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Age", text: $myAge)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        SecureField("Password", text: $myPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            self.writeDB(self.uuid, self.myName, self.myAge, self.myPassword)
                        }){
                            Text("Registration!")
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
