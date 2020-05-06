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
    let beschreibung : String
    let mengePersonen : Int
}

class Recipe : ObservableObject {
    @Published var items = [RecipesItem]()
        {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try?
                encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let ReItems = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            
            if let decoded = try?
                decoder.decode([RecipesItem].self, from: ReItems){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct RecipesView: View {
    @State private var showingAddRecipe = false
    @ObservedObject var expenses = Expense()
    @EnvironmentObject var recipeBook : Recipe
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recipeBook.items){ item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.beschreibung)
                                .font(.headline)
                        }
                    }
                }.onDelete(perform: removeRecipes)
            }
            .opacity(0.7)
            .background(Image("Background")
            .resizable()
            .edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Rezepte")
        }
    }
    
    func removeRecipes(at offsets: IndexSet){
        recipeBook.items.remove(atOffsets: offsets)
    }
    
}
struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
