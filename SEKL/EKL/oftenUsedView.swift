//
//  oftenUsedView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 20.03.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct oftenUsedView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Hello")
            }.navigationBarTitle("Häufig genutzt")
        }
    }
}

struct oftenUsedView_Previews: PreviewProvider {
    static var previews: some View {
        oftenUsedView()
    }
}
