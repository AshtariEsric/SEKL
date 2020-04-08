//  FeedbackView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 01.04.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.

import SwiftUI
import MessageUI

class Feedback : ObservableObject {
    @Published var feedBackText : String = ""
    @Published var userName : String = ""
    
}
struct FeedbackView: View {
    //Feedback Mail
    @EnvironmentObject var feedbackContent : Feedback
    @EnvironmentObject var userRating : UserRating
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    
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
                    Button(action: {
                            self.isShowingMailView.toggle()
                        }) {
                            Text("Absenden")
                        }
                    .disabled(!MFMailComposeViewController.canSendMail())
                    .sheet(isPresented: $isShowingMailView) {
                            MailView(result: self.$result)
                                .environmentObject(self.feedbackContent)
                                .environmentObject(self.userRating)
                        }
                    Spacer()
                    }.navigationBarTitle("Feedback")
                    .padding()
                }
            }
        }
}
    //Star Rating functionality
struct abfrageView: View {
    @State private var userName : String = ""
    @State private var feedBackText : String = ""
        
    @EnvironmentObject var feedback : Feedback
    @EnvironmentObject var userRating : UserRating
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Image(systemName: "person")
                Text("NAME:")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                TextField("Dein Name", text: $feedback.userName)
                    .multilineTextAlignment(.center)
                }
            HStack{
                Image(systemName: "ellipses.bubble")
                Text("BESCHREIBUNG:")
                    .font(.headline)
                Spacer()
                }
            TextField("Beschreibe dein Problem", text: $feedback.feedBackText)
                .frame(width: 200, height: 100)
                .lineLimit(nil)
            HStack{
                Image(systemName: "star.lefthalf.fill")
                Text("BEWERTUNG")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                Rating()
                }
        }.padding()
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
