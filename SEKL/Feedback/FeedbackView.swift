//
//  FeedbackView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 01.04.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct FeedbackView: View {
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack(alignment: .center){
                    Text("Du hast Anmerkungen oder Verbesserungsvorschläge? \nTeile sie uns mit und wir kümmern uns schnellstmöglich darum!")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Spacer()
                    abfrageView()
                    Spacer()
                    }.navigationBarTitle("Feedback")
                    .padding()
                }
            }
        }
    }

struct abfrageView: View {
        @State private var userName : String = ""
        @State private var feedBackText : String = ""
        @EnvironmentObject var userRating : UserRating
    
    var body: some View {

        VStack(alignment: .leading, spacing: 20){
            HStack{
                Image(systemName: "person")
                Text("NAME:")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                TextField("Dein Name", text: $userName)
                    .multilineTextAlignment(.center)
                }
            
            HStack{
                Image(systemName: "ellipses.bubble")
                Text("BESCHREIBUNG:")
                    .font(.headline)
                Spacer()
                }
            TextField("Beschreibe dein Problem", text: $feedBackText)
                .frame(width: 200, height: 100)
                .lineLimit(nil)
            
            HStack{
                Image(systemName: "star.lefthalf.fill")
                Text("BEWERTUNG")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                Rating()
                }
            
            Button(action: {print("hi")})
            {
                Text("Absenden")
            }
            
        }.padding()
    }
}

//struct FeedbackView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedbackView()
//    }
//}
