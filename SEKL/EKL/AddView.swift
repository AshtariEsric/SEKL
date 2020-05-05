//
//  AddThings.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 26.02.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expense : Expense
    @ObservedObject var recipe : Recipe
    
    @State private var beschreibung = ""
    @State private var menge = ""
    @State private var mengePersonen = ""
    
    @State private var rezeptOrIngredients = "Default"
    static let subTitle = ["Rezept", "Zutat"]
    
    @State private var unitType = "ml"
    static let units = ["ml", "liter", "gramm", "kg", "Stk"]
    
    @State private var type = "Default"
    static let types = ["Nahrungsmittel","Haushaltsartikel", "Getränke", "Obst und Gemüse", "Tiefkühl", "Drogerie und Kosmetik", "Baby und Kind", "Tierartikel", "Süßigkeiten und Salzigkeiten"]
        .sorted()
    
    @State private var auswahl : Int = 0
    @State private var person = ""
    
    @State private var defaultAnzahlPerson = 1
    static let anzahlPers = [1,2,3,4,5,6,7,8,9,10]
    
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Rezept oder Zutat", selection: $rezeptOrIngredients){
                    ForEach(Self.subTitle, id: \.self)
                    {
                        Text($0)
                    }
                }
                
                if rezeptOrIngredients == "Zutat" {
                    Picker("Type", selection: $type){
                        ForEach(Self.types, id:\.self){
                            Text($0)
                        }
                    }
                    TextField("Beschreibung", text: $beschreibung)
                    HStack{
                        TextField("Menge", text: $menge)
                        Picker(selection: $unitType, label: Text("Anzahl Personen")){
                            ForEach(Self.units, id:\.self)
                            {
                                Text($0)
                            }
                        }.pickerStyle(WheelPickerStyle())
                            .frame(width: 100, height: 100)
                    }
                }
                
                if rezeptOrIngredients == "Rezept"
                {
                    TextField("Beschreibung", text: $beschreibung)
                    HStack{
                        TextField("Anzahl Personen", text: $mengePersonen);
//                      *** FEATURE ***
//                        Picker(selection: $mengePersonen, label: Text("Anzahl Personen")){
//                            ForEach(self.anzahlPers, id:\.self)
//                            {
//                                Text(String($0))
//                            }
//                        }.pickerStyle(WheelPickerStyle())
//                            .frame(width: 100, height: 100)
                    }
                }
                Button(action: {
                    if self.rezeptOrIngredients == "Rezept" {
                        if let actualMenge = Int(self.mengePersonen){
                            let item = RecipesItem(beschreibung: self.beschreibung, mengePersonen: actualMenge)
                            self.recipe.items.append(item)
                            self.presentationMode.wrappedValue.dismiss()
                            print("REZEPT!!!")
                            print(self.mengePersonen)
                            print(self.beschreibung)
                            
                        } else {
                            print(self.recipe)
                            print(self.mengePersonen)
                            print(self.beschreibung)
                        }
                       
                    }
                    if(self.rezeptOrIngredients == "Zutat"){
                        if let actualMenge = Int(self.menge){
                            let item = ExpenseItem(beschreibung: self.beschreibung, menge: actualMenge, type: self.type, unitType: self.unitType)
                            self.expense.items.append(item)
                            self.presentationMode.wrappedValue.dismiss()
                            print("ZUTAT!!!")
                        }
                    }
                })
                {
                    if(rezeptOrIngredients == "Default"){
                        Text("Hinzufügen von ...")
                    }
                    if(rezeptOrIngredients == "Zutat"){
                        Text("Hinzufügen einer Zutat")
                    }
                    if(rezeptOrIngredients == "Rezept"){
                        Text("Hinzufügen eines Rezepts")
                    }
                }
            }
            .navigationBarTitle("Hinzufügen von...")
        }
    }
}

struct AddThings_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expense: Expense(), recipe: Recipe())
    }
}
