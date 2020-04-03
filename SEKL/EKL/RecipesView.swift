//
//  RecipesView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 20.03.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct RecipesItem : Identifiable, Codable {
    let id = UUID()
    var name : String
    var expenseItem : ExpenseItem
}

class Recipe : ObservableObject {
    @Published var ReItems = [RecipesItem]()
        {
            didSet {
                let encoder = JSONEncoder()
                if let encoded = try?
                    encoder.encode(ReItems){
                    UserDefaults.standard.set(encoded, forKey: "ReItems")
                }
            }
        }
    init() {
        if let ReItems = UserDefaults.standard.data(forKey: "ReItems"){
        let decoder = JSONDecoder()
        
        if let decoded = try?
            decoder.decode([RecipesItem].self, from: ReItems){
            self.ReItems = decoded
            return
        }
    }
    self.ReItems = []
    }
}

struct RecipesView: View {
    @State private var showingAddRecipe = false
    @ObservedObject var recipes = Recipe()
    
    
    var body: some View {
        NavigationView {
            List{
                ForEach(recipes.ReItems) { ReItems in
                    HStack{
                        VStack(alignment: .leading){
                            Text(ReItems.name)
                                .font(.headline)
                            }
                        }
                    }
                    .onDelete(perform: removeRecipes)
                }
                .opacity(0.7)
                .background(Image("Background")
                .resizable()
                .edgesIgnoringSafeArea(.all))
                .navigationBarTitle("Rezepte")
                .navigationBarItems(trailing:
                               Button(action: {
                                   self.showingAddRecipe = true
                           }){
                               Image(systemName: "plus")
                           })
        }
    }
            
    func removeRecipes(at offsets: IndexSet){
        recipes.ReItems.remove(atOffsets: offsets)
    }
}
struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
