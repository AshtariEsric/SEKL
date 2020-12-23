//
//  RecipeIngredientsView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 20.11.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI
extension UIApplication
{
    func endEditing(_force : Bool)
    {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(_force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier
{
    var gesture = DragGesture().onChanged{_ in UIApplication.shared.endEditing(_force: true)}
    func body(content: Content) -> some View
    {
        content.gesture(gesture)
    }
}

extension View
{
    func resignKeyboardOnDragGesture() -> some View
    {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

struct BlueButtonStyle: ButtonStyle
{
    func makeBody(configuration: Self.Configuration) -> some View
    {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .contentShape(Rectangle())
            .foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : Color.white)
            .listRowBackground(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
    }
}
/*
    Zutaten pflegen Button, zum hinzufügen von Zutaten zu einem Rezept.
 **/
struct RecipeIngredientsView: View {
    let myArray = ["Dennis", "Tessa", "Peter", "Anna", "Tessa", "Klaus", "Xyan", "Zuhau", "Clown", "Brot", "Bauer"]
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false

    
    var body: some View {
            VStack
            {
                HStack
                {
                    HStack
                    {
                        Image(systemName: "magnifyingglass")
                        TextField("Suche", text: $searchText, onEditingChanged: { isEditing in self.showCancelButton = true}, onCommit: {
                            print("onCommit")
                        }).foregroundColor(.primary)
                        
                        Button(action: {
                            self.searchText = searchText
                            }){
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                            }
                        }.padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10.0)
                        
                        if showCancelButton {
                        Button("Abbrechen")
                            {
                            UIApplication.shared.endEditing(_force: true)
                            self.searchText = ""
                            self.showCancelButton = false
                            }
                                .foregroundColor(Color(.systemBlue))
                            }
                        }
                        .padding(.horizontal)
                        .navigationBarHidden(showCancelButton)
                        
                        //Gefilterte Liste der Namen aus meinem Array
                List {
                    ForEach(myArray.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self)
                        {
                        searchText in Text(searchText)
                    }

                    Button(action:{})
                        {
                        HStack
                        {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 20,height:20)
                            Text("New Test")
                        }
                    }.padding()
                    .accentColor(Color(UIColor.systemRed))
                }
                .navigationBarTitle(Text("Suche"))
                .resignKeyboardOnDragGesture()
            }
        }
    }


struct RecipeIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeIngredientsView()
    }
}

