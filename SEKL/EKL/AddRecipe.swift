//
//  AddRecipe.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 28.09.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI
struct temporaryRecipe : Identifiable, Codable
{
    var id = UUID()
    var beschreibung : String
    var recipeCollection = [RecipesItem]()
    
}


struct AddRecipe: View
{
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var recipe = Recipe()
    @State var tempRec = temporaryRecipe(beschreibung: "")
    
    @State private var beschreibungRezept = ""
    @State private var anzahlPersonenRezept = ""
    @State private var zutatRezept = ""

    
    @State private var recipeArray = [""]
    
    var body : some View
    {
        NavigationView{
            VStack{
                Form {
                    Text("\(beschreibungRezept)")
                        .font(.headline)
                    if !anzahlPersonenRezept.isEmpty{
                        Text("Für \(anzahlPersonenRezept) Personen")
                            .font(.subheadline)
                    }
                    
                        List(self.recipe.items) { RecipesItem in
                            Text(RecipesItem.beschreibung)
  
                        }
                        .padding(.leading)
                        .edgesIgnoringSafeArea(.all)
                    }
                }.background(Color.gray)
                Spacer()
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

                        .frame(width: 100, height: 50)
                    }
                    Button(action: {

                        
//                        if let myZutatAnzahl = NumberFormatter().number(from: zutatAnzahl)
//                        {
//                            myIntZutatAnzahl = myZutatAnzahl.intValue
//                            var addZutat = rezeptZutat(zutat: zutatRezept, anzahl: myIntZutatAnzahl)
//
//
//                            //Clear two TextFields
//                            zutatRezept = ""
//                            zutatAnzahl = ""
//                        } else
//                        {
//
//                        }
//                        recipeArray.append(zutatRezept)
//                        zutatRezept = ""
//                        zutatAnzahl = ""
//                        recipeArray.append(zutatRezept)
//                        zutatRezept = ""
//                        zutatAnzahl = ""
                    }){
                        Image(systemName: "plus.circle")
                        TextField("Zutat", text: $zutatRezept)

                    }
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.leading)
                Spacer()
                
                Form {

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
    
    func combineRecipeElements(zutatAnzahl : Int, zutatRezept: String) -> rezeptZutat
    {
        let myRecipe = rezeptZutat(zutat: zutatRezept, anzahl: zutatAnzahl)
        return myRecipe
    }
    
    class rezeptZutat
    {
        var zutat : String
        var anzahl : Int
        
        init(zutat: String, anzahl: Int)
        {
            self.zutat = zutat
            self.anzahl = anzahl
        }
    }
    
    func removeItems(at offsets: IndexSet){
        recipe.items.remove(atOffsets: offsets)
    }
}
