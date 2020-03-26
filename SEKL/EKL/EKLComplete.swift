//
//  EKLComplete.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 26.02.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct ExpenseItem : Identifiable, Codable {
    let id = UUID()
    let beschreibung : String
    let menge : Int
    let type : String
    let price : Int
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
    @State private var showingAddExpense = false
    
    var body: some View {
        TabView {
            NavigationView {
                List {
                    ForEach(expenses.items){ item in
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.beschreibung)
                                    .font(.headline)
                                Text(String(item.menge) + " Stk.")
                                Text("€" + String(item.price))
                            }
                        }
                    }
                .onDelete(perform: removeItems)
                }
            .navigationBarTitle("Einkaufsliste")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showingAddExpense = true
                }){
                    Image(systemName: "plus")
                })
                    .sheet(isPresented: $showingAddExpense){
                        AddThings(expense: self.expenses)
                }
            }
            .tabItem {
                Image(systemName: "bag")
                Text("Buylist")
            }
            
            RecipesView()
                    .tabItem {
                        Image(systemName: "doc.text")
                        Text("Receipts")
                    }
            oftenUsedView()
                    .tabItem{
                        Image(systemName: "repeat")
                        Text("Often used")
                    }
            ShareEKL()
                    .tabItem{
                        Image(systemName: "paperplane")
                        Text("Share")
                    }
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
    
}
struct EKLComplete_Previews: PreviewProvider {
    static var previews: some View {
        EKLComplete()
    }
}