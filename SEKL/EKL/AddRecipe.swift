//
//  AddRecipe.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 31.05.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct AddRecipe: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expense : Expense
    @ObservedObject var recipe : Recipe
    
    @State private var beschreibung = ""
    @State private var menge = ""
    @State private var mengePersonen = ""
    
    
    var body: some View {
            NavigationView {
                Form {
                        TextField("Beschreibung", text: $beschreibung)
                        HStack{
                            TextField("Anzahl Personen", text: $mengePersonen)
                        }
                    Button(action: {
                        if self.rezeptOrIngredients == "Rezept" {
                            if let actualMenge = Int(self.mengePersonen){
                                let item = RecipesItem(beschreibung: self.beschreibung, mengePersonen: actualMenge)
                                self.recipe.items.append(item)
                                self.presentationMode.wrappedValue.dismiss()
                                print("REZEPT!!!")
                                print(item.mengePersonen)
                                print(item.beschreibung)
                            }
                        }
                        if(self.rezeptOrIngredients == "Zutat"){
                            if let actualMenge = Int(self.menge){
                                let item = ExpenseItem(beschreibung: self.beschreibung, menge: actualMenge, type: self.type, unitType: self.unitType, itemImage: self.type)
                                self.expense.items.append(item)
                                self.presentationMode.wrappedValue.dismiss()
                                print("ZUTAT!!!")
                            }
                        }
                    })
                }
                .navigationBarTitle("Hinzufügen von...")
            }
        }
}

struct AddRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipe(expense: Expense(), recipe: Recipe())
    }
}
