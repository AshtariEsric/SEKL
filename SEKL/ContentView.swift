//  ContentView.swift
//  EKL
//
//  Created by Dennis Hasselbusch on 09.09.19.
//  Copyright © 2019 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    //signInSuccess auf True, damit nicht permanent eingeloggt werden muss - muss bei release version zurück auf false geändert werden
    @State var signInSuccess = true
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var device : Device
    
    func getUser(){
        session.listen()
    }
    
    var body : some View {
        return Group {
            if signInSuccess {
                if self.device.isLandscape {
                    EKLComplete()
                } else {
                    EKLComplete()
                }
            } else {
                if self.device.isLandscape{
                    LoginFormView(signInSuccess : $signInSuccess)
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
