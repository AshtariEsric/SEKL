//
//  RecipesView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 20.03.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct RecipesView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Hello")
            }.navigationBarTitle("Rezepte")
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
