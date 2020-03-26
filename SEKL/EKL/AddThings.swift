//
//  AddThings.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 26.02.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

class ingredientsList: ObservableObject{
    @Published var ingredients = ["Butter", "Mais"]
}

struct AddThings: View {
    @Environment(\.presentationMode) var presentationMode
    //Beide Views teilen das selbe Array
    @ObservedObject var expense: Expense
    @ObservedObject var ingredients = ingredientsList()
    @State private var beschreibung = ""
    @State private var menge = ""
    @State private var price = ""
    @State private var rezeptOrIngredients = "Default"
    static let receipts = ["Rezept", "Zutat"]
    
    @State private var unitType = "Default"
    static let units = ["ml", "liter", "gramm", "kg", "Stk"]
    
    @State private var type = "Default"
    static let types = ["Nahrungsmittel","Haushaltsartikel", "Getränke", "Obst und Gemüse", "Tiefkühl", "Drogerie und Kosmetik", "Baby und Kind", "Tierartikel", "Süßigkeiten und Salzigkeiten"]
        .sorted()
    
    @State private var person = ""
    var anzahlPers = [1,2,3,4,5,6,7,8,9,10]
    
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Rezept oder Zutat", selection: $rezeptOrIngredients){
                    ForEach(Self.receipts, id: \.self)
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
                    TextField("Menge", text: $menge)
                    TextField("Preis", text: $price)
                    
                }
                
                if rezeptOrIngredients == "Rezept"
                {
                    TextField("Beschreibung", text: $beschreibung)
                    HStack{
                        Text("Anzahl Personen");
                        Picker(selection: $person, label: Text("Anzahl Personen")){
                            ForEach(0 ..< anzahlPers.count)
                            {
                                Text(String(self.anzahlPers[$0]) )
                            }
                    }.pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 100)
                    }
                }
                Button(action: {
                    if let actualPrice = Int(self.price){
                        let item = ExpenseItem(beschreibung: self.beschreibung, menge: Int(self.menge) ?? 0, type: self.type, price: actualPrice, unitType: self.unitType)
                        self.expense.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                        self.ingredients.ingredients.append(self.beschreibung)

                        print(self.ingredients)
                        
                    }
                }){
                    Text("Hinzufügen!")
                }
            }
            .navigationBarTitle("Hinzufügen von...")
        }
    }
}

struct AddThings_Previews: PreviewProvider {
    static var previews: some View {
        AddThings(expense: Expense())
    }
}
