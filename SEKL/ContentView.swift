//
//  ContentView.swift
//  EKL
//
//  Created by SkyByte on 09.09.19.
//  Copyright © 2019 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI


struct ContentView : View {
   @State var signInSuccess = false
    
    var body : some View {
        return Group {
            if signInSuccess {
                EKLComplete()
                //AppHome()
            } else {
                LoginFormView(signInSuccess : $signInSuccess)
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
