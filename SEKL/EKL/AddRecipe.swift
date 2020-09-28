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
    
    @State private var recipeArray = [""]
    
    var body : some View
    {
        NavigationView{
            VStack{
                Form
                {
                    TextField("Beschreibung", text: $beschreibungRezept)
                    HStack{
                        TextField("Anzahl Personen", text: $anzahlPersonenRezept)
                        Spacer()
                        Text("Personen")
                    }
                    HStack{
                        Button(action: {
                            recipeArray.append(zutatRezept)
                            zutatRezept = ""
                        }){
                            Image(systemName: "plus.circle")
                        }
                        TextField("Zutat", text: $zutatRezept)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.leading)
                List {
                    Text("\(beschreibungRezept)")
                        .font(.headline)
                    Text("Für \(anzahlPersonenRezept) Personen")
                        .font(.subheadline)
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
            }.navigationBarTitle("Rezept hinzufügen")
        }
    }
    
    func removeItems(at offsets: IndexSet){
        recipe.items.remove(atOffsets: offsets)
    }
}
