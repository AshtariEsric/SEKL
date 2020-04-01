//
//  ShareEKL.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 20.03.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct ShareView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Hello")
            }.navigationBarTitle("Teilen")
        }
    }
}

struct ShareEKL_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
