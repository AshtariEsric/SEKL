//
//  EKLComplete.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 26.02.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct ExpenseItem : Identifiable, Codable {
    var id = UUID()
    let beschreibung : String
    let menge : Int
    let type : String
    let unitType : String
    let itemImage : String
}

//ObservableObject können mehr als in einer View genutzt werden
class Expense: ObservableObject {
    @Published var items = [ExpenseItem]()
        {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try?
                encoder.encode(items){
                UserDefaults.standard.set(encoded,forKey:"Items")
            }
        }
    }
    init(){
        if let items =  UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            
            if let decoded = try?
                decoder.decode([ExpenseItem].self,from: items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct EKLComplete: View {
    @ObservedObject var expenses = Expense()
    @EnvironmentObject var recipeBook : Recipe
    @State private var showingAddExpense = false
    
    var body: some View {
        TabView {
            NavigationView {
                List {
                    self.listContent(newArray: Array(zip(expenses.items, recipeBook.items)))
                }.onAppear(perform: {UITableView.appearance().separatorStyle = .none})
                .opacity(0.7)
                .background(Image("Background")
                .resizable()
                .edgesIgnoringSafeArea(.all))
                    
                .navigationBarTitle("Einkaufsliste")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showingAddExpense = true
                    }){
                            Image(systemName: "cart.badge.plus")
                        
                })
                    .sheet(isPresented: $showingAddExpense){
                        AddView(expense: self.expenses, recipe: self.recipeBook)
                }
            }
            .tabItem {
                Image(systemName: "bag")
                Text("Buylist")
            }
            RecipesView()
                .tabItem {
                    Image(systemName: "doc.text")
                    Text("Bibliothek")
            }
            FeedbackView()
                .tabItem{
                    Image(systemName: "exclamationmark.bubble")
                    Text("Feedback")
            }
           /*
            Häufig genutzt View - ggf. nachträglich?
             oftenUsedView()
                .tabItem{
                    Image(systemName: "repeat")
                    Text("Häufig genutzt")
            }*/
            ShareView()
                .tabItem{
                    Image(systemName: "paperplane")
                    Text("Rezepte teilen")
            }
        }
    }
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    func listContent(newArray: [Any]) -> some View {
        ForEach(expenses.items, id: \.id){ item in    
            HStack{
                VStack(alignment: .leading){
                    Text(item.beschreibung)
                        .font(.headline)
                    Text(String(item.menge) + " \(item.unitType)")
                }
                Spacer()
                Image(item.itemImage)
                .resizable()
                    .frame(width: 30, height: 30)
            }
        }.onDelete(perform: removeItems)
    }
}

struct EKLComplete_Previews: PreviewProvider {
    static var previews: some View {
        EKLComplete()
    }
}
