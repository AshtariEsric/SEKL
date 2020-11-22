//  FeedbackView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 01.04.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.

import SwiftUI
import MessageUI

/*
    ObservableObject für den feedbackText und den userName. Diese werden in der MailView automatisch bei absenden mit übernommen und entsprechend eingefügt, sodass der User diese nicht erneut eintragen muss.
 **/
class Feedback : ObservableObject {
    @Published var feedBackText : String = ""
    @Published var userName : String = ""
    
}
/*
 
 */
struct FeedbackView: View {
    @EnvironmentObject var feedbackContent : Feedback
    @EnvironmentObject var rating : UserRating
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack(alignment: .center){
                    Text("Du hast Anmerkungen oder Verbesserungsvorschläge? \nTeile sie uns mit!")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Spacer()
                    abfrageView()
                    Spacer()
                    //Wenn Absenden geklickt wird, öffne MailView. Dabei übergib zwei environmentObject (rating und feedbackContent)
                    Button(action: {
                        self.isShowingMailView.toggle()
                    }) {
                        Text("Absenden")
                    }
                    .disabled(!MFMailComposeViewController.canSendMail())
                    .sheet(isPresented: $isShowingMailView) {
                        MailView(result: self.$result)
                            .environmentObject(self.feedbackContent)
                            .environmentObject(self.rating)
                    }
                    Spacer()
                }.navigationBarTitle("Feedback")
                    .padding()
            }
        }
    }
}
/*
    AbfrageView fragt den Usernamen und die Beschreibung ab.
    Öffnet im Anschluss Rating()
    feedbackContent wird ebenfalls in Rating verwendet.
 
 */
struct abfrageView: View {
    @State private var userName : String = ""
    @State private var feedBackText : String = ""
    
    @EnvironmentObject var feedbackContent : Feedback
    @EnvironmentObject var rating : UserRating
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Image(systemName: "person")
                Text("NAME:")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                TextField("Dein Name", text: $feedbackContent.userName)
                    .multilineTextAlignment(.center)
            }
            HStack{
                Image(systemName: "ellipses.bubble")
                Text("BESCHREIBUNG:")
                    .font(.headline)
                Spacer()
            }
            TextField("Beschreibe dein Problem", text: $feedbackContent.feedBackText)
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
