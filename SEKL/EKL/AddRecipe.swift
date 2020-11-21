//
//  AddRecipe.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 28.09.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct AddRecipe: View
{
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var recipe : Recipe
    
    @State private var beschreibungRezept = ""
    @State private var zutatRezept = ""
    @State private var anzahlPersonenRezept = ""
    @State private var unitType = "ml"
    @State private var recipeArray = [""]
    @State private var zutatAnzahl = ""

    static let units = ["ml", "liter", "gramm", "kg", "Stk"]

    @State private var rezeptOrIngredients = "Rezept"
    @State private var mengePersonen = ""
    @State private var beschreibung = ""
    @State private var actualMenge = 0
    
    var body : some View
    {
        NavigationView{
            VStack{
                Form
                {
                    Section(header: Text("Allgemeines"))
                    {
                        TextField("Beschreibung", text: $beschreibung)
                        TextField("Anzahl Personen", text: $mengePersonen)
                    }
                    if !beschreibung.isEmpty && !mengePersonen.isEmpty
                    {
                        Section(header: Text("Zutaten"))
                            {
                                NavigationLink(destination: RecipeIngredientsView()){
                                Text("Zutaten pflegen für \(mengePersonen) Personen")
                                }
                            }
                    }
                    
                    Button(action: {
                                if let actualMenge = Int(self.mengePersonen){
                                    let item = RecipesItem(beschreibung: self.beschreibung, mengePersonen: actualMenge)
                                    self.recipe.items.append(item)
                                    self.presentationMode.wrappedValue.dismiss()
                                    print(item.mengePersonen)
                                    print(item.beschreibung)
                                }
                    }){Text("Hinzufügen eines Rezepts")}
                    }
                
            }.navigationBarTitle("Rezept hinzufügen")
        }
    }
}

