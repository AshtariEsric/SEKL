//
//  MailView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 07.04.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//
//
//  FeedbackView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 01.04.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//
import SwiftUI
import UIKit
import MessageUI

struct MailView: UIViewControllerRepresentable {
    @EnvironmentObject var feedbackContent : Feedback
    @EnvironmentObject var userRating : UserRating
    
    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setToRecipients(["test@gmail.com"])
        vc.setSubject("Feedback SEKL")
        vc.setMessageBody("Hallo ... \(feedbackContent.userName)\nWie geht es dir? \(userRating.rating)", isHTML: true)
//      vc.setMessageBody("Hallo \(Feedback.self.userName)", isHTML: true)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {

    }
}
