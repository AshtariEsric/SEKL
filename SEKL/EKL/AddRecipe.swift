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
    
    var body : some View
    {
        NavigationView{
            VStack{
                Form
                {
                    TextField("Beschreibung", text: $beschreibungRezept)
                    HStack{
                        TextField("Anzahl Personen", text: $anzahlPersonenRezept)
                        Text("Personen")
                        Spacer()
                    }
                    HStack{
                        TextField("Zutat", text: $zutatRezept)
                    }
                    HStack{
                        TextField("Anzahl", text: $zutatAnzahl)
                        Picker(selection: $unitType, label: Text("")){
                            ForEach(Self.units, id:\.self)
                            {
                                Text($0)
                            }
                        }
                        .frame(width: 100, height: 50)
                    }
                    Button(action: {
                        recipeArray.append(zutatRezept)
                        zutatRezept = ""
                        zutatAnzahl = ""
                    }){
                        Image(systemName: "plus.circle")
                    }
                    
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.leading)
                Spacer()
                Form {
                    Text("\(beschreibungRezept)")
                        .font(.headline)
                    if !anzahlPersonenRezept.isEmpty{
                        Text("Für \(anzahlPersonenRezept) Personen")
                            .font(.subheadline)
                    }
                    VStack(alignment: .leading){
                        //TODO: padding is not working!
                        List(recipeArray, id: \.self){
                            string in
                            Text(string)
                        }
                        .padding(.leading)
                        .edgesIgnoringSafeArea(.all)
                    }
                }
                Spacer()
                Button(action:{
                    print("Finish")
                }){
                    Text("Rezept abschließen!")
                        .overlay(RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.green, lineWidth: 2))
                }
            }.navigationBarTitle("Rezept hinzufügen")
        }
    }
    
    func removeItems(at offsets: IndexSet){
        recipe.items.remove(atOffsets: offsets)
    }
}
