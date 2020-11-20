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
<<<<<<< HEAD
    @State private var anzahlPersonenRezept = ""
=======
>>>>>>> parent of fa55d1b... 0.63.2
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
                Form {
                    Text("\(beschreibungRezept)")
                        .font(.headline)
                    if !anzahlPersonenRezept.isEmpty{
                        Text("Für \(anzahlPersonenRezept) Personen")
                            .font(.subheadline)
                    }
                    VStack(alignment: .leading){
                        List(self.tempRec.recipeCollection){_ in
                            Text("\(tempRec.recipeCollection)")
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
<<<<<<< HEAD
                        
                        if let myZutatAnzahl = NumberFormatter().number(from: zutatAnzahl)
                        {
                            myIntZutatAnzahl = myZutatAnzahl.intValue
                            var addZutat = rezeptZutat(zutat: zutatRezept, anzahl: myIntZutatAnzahl)
                            
                            
                            //Clear two TextFields
                            zutatRezept = ""
                            zutatAnzahl = ""
                        } else
                        {
                            
                        }
=======
                        recipeArray.append(zutatRezept)
                        zutatRezept = ""
                        zutatAnzahl = ""
>>>>>>> parent of fa55d1b... 0.63.2
                    }){
                        Image(systemName: "plus.circle")
                    }
                    
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.leading)
                Spacer()
<<<<<<< HEAD
=======
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
>>>>>>> parent of fa55d1b... 0.63.2
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
    
<<<<<<< HEAD
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
    
=======
>>>>>>> parent of fa55d1b... 0.63.2
    func removeItems(at offsets: IndexSet){
        recipe.items.remove(atOffsets: offsets)
    }
}
