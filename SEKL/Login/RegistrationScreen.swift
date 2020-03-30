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
                        
                        Button(action: {
                            print("test")
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
