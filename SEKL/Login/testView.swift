//
//  testView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 26.03.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct testView: View {
        @State private var enableLogging = false
        @State private var selectedColor = 0
        @State private var colors = ["Red", "Green", "Blue"]
    
        @State private var myName : String = ""
        @State private var myAge : String = ""
        @State private var myPassword : String = ""
        @State private var email : String = ""
        @State private var uuid = UUID().uuidString
    
       var body: some View {
           NavigationView {
               Form {
                   Section(footer: Text("Note: Enabling logging may slow down the app")) {
                       Picker(selection: $selectedColor, label: Text("Select a color")) {
                           ForEach(0 ..< colors.count) {
                               Text(self.colors[$0]).tag($0)
                           }
                       }.pickerStyle(SegmentedPickerStyle())

                    TextField("Nickname", text: $myName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Age", text: $myAge)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Password", text: $myPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                       Toggle(isOn: $enableLogging) {
                           Text("Enable Logging")
                       }
                   }

                   Section {
                       Button(action: {
                            print("hello")
                       }) {
                           Text("Save changes")
                       }
                   }
               }.navigationBarTitle("Settings")
           }
       }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
