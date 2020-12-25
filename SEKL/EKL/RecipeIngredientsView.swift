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
                        
                        //Gefilterte Liste mit den Namen aus meinem Array
                List {
                    VStack{
                        ForEach(myArray.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self)
                            {
                            searchText in VStack {
                            CardView(searchText: searchText)
                            }
                        }
                        Spacer()
                    }
                }
                .navigationBarTitle(Text("Suche"))
                .resignKeyboardOnDragGesture()
            }
        }
    }

struct CardView : View
{
    @State var searchText = ""
    var body : some View
    {
        HStack{
            Text(searchText)
            Spacer()
            Button(action: {print("\(searchText) btn pressed!")})
                {
                Image(systemName: "circle")
                .frame(width:25, height:25)
                .clipShape(Circle())
                }
             }
    }
}


struct RecipeIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeIngredientsView()
    }
}

