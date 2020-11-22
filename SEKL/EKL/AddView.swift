//
//  AddThings.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 26.02.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

/*
    AddView ist für das Hinzufügen von neuen Zutaten und Rezepten auf die Einkaufsliste zuständig.
 **/

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expense : Expense
    @ObservedObject var recipe : Recipe
    
    @State private var beschreibung = ""
    @State private var menge = ""
    @State private var mengePersonen = ""
    
    //Entscheidungsfindung Rezept oder Zutat
    @State private var rezeptOrIngredients = "Default"
    static let subTitle = ["Rezept", "Zutat"]
    
    //unitType für das Hinzufügen von Zutaten
    @State private var unitType = "ml"
    static let units = ["ml", "liter", "gramm", "kg", "Stk"]
    
    //Wichtig für die hinterlegten ICONS. .sorted damit es alphabetisch sortiert ist.
    @State private var type = "Default"
    static let types = ["Nahrungsmittel","Haushaltsartikel", "Getränke", "Obst und Gemüse", "Tiefkühl", "Drogerie und Kosmetik", "Baby und Kind", "Tierartikel", "Süßigkeiten und Salzigkeiten"]
        .sorted()
    
    @State private var auswahl : Int = 0
    @State private var person = ""
    
    //Entscheidend zur Berechnung bei Rezepten (Menge Personen * Rezept = Anzahl der benötigten Ressourcen)
    @State private var defaultAnzahlPerson = 1
    static let anzahlPers = [1,2,3,4,5,6,7,8,9,10]
    @State private var itemImage = ""
    
    //Image Sammlung für die Typen.
    func myImage() -> some View {
        switch type {
            case "Nahrungsmittel": itemImage = "Nahrungsmittel" //x
            case "Haushaltsartikel": itemImage = "Haushaltsartikel" //x
            case "Getränke": itemImage = "Getränke" //x
            case "Obst und Gemüse": itemImage = "Obst und Gemüse" //x
            case "Tiefkühl": itemImage = "Tiefkühl" //X
            case "Drogerie und Kosmetik": itemImage = "Drogerie"
            case "Baby und Kind": itemImage = "Baby und Kind" //x
            case "Tierartikel": itemImage = "Tierartikel" //x
            case "Süßigkeiten und Salzigkeiten": itemImage = "Süßigkeiten und Salzigkeiten" //x
                
        default: itemImage = "empty"
        }
        return Image(itemImage)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header:Text("Art"))
                    {
                    ///TODO: SLIDER REZEPT ODER ZUTAT!
                        Picker("Rezept oder Zutat", selection: $rezeptOrIngredients){
                            ForEach(Self.subTitle, id: \.self)
                            {
                                Text($0)
                            }
                    }
                }
                    if rezeptOrIngredients == "Zutat" {
                        Section(header: Text("Details"))
                        {
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
                            myImage()
                        }
                    }
                    }
                
                
                if rezeptOrIngredients == "Rezept"
                {
                    
                        Section(header: Text("Allgemeines"))
                            {
                            TextField("Beschreibung", text: $beschreibung)
                            TextField("Anzahl Personen", text: $mengePersonen)
                            }
                    if !beschreibung.isEmpty && !mengePersonen.isEmpty{
                        Section(header: Text("Zutaten"))
                            {
                            NavigationLink(destination: RecipeIngredientsView()){
                                Text("Zutaten pflegen")
                            }
                            }
                    }
                }
                
                Button(action: {
                    if self.rezeptOrIngredients == "Rezept" {
                        if let actualMenge = Int(self.mengePersonen){
                            let item = RecipesItem(beschreibung: self.beschreibung, mengePersonen: actualMenge)
                            self.recipe.items.append(item)
                            self.presentationMode.wrappedValue.dismiss()
                            print(item.mengePersonen)
                            print(item.beschreibung)
                            
                        } else {
                            print(self.recipe)
                            print(self.mengePersonen)
                            print(self.beschreibung)
                        }
                    }
                    if(self.rezeptOrIngredients == "Zutat"){
                        if let actualMenge = Int(self.menge){
                            let item = ExpenseItem(beschreibung: self.beschreibung, menge: actualMenge, type: self.type, unitType: self.unitType, itemImage: self.type)
                            self.expense.items.append(item)
                            self.presentationMode.wrappedValue.dismiss()

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
