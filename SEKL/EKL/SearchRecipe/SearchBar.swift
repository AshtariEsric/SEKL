//
//  SearchBar.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 19.04.21.
//  Copyright © 2021 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct SearchBar : View {
    
    private var todoItems = [ ToDoItem(name: "Meet Eddie for lunch"),
                              ToDoItem(name: "Buy toilet paper"),
                              ToDoItem(name: "Write a new tutorial"),
                              ToDoItem(name: "Buy two bottles of wine"),
                              ToDoItem(name: "Prepare the presentation deck")
    ]
    
    @State private var searchText = ""
    
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                HStack {
                    SearchView(text: $searchText)
                }
                List(todoItems.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { item in
                    CardView(searchText: item.name)
                }
            }
        }.navigationBarTitle("Rezepte")
        .padding()
    }
}


struct SearchView: View {
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                                
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}
