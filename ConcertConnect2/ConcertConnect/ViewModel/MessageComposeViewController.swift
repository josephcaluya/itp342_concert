//
//  MessageComposeViewController.swift
//  ConcertConnect
//
//  Created by Joseph Caluya on 4/30/24.
//

import SwiftUI
import MessageUI

struct MessageComposeViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = MFMessageComposeViewController
    // keeps track of when button was tapped
    @Binding var isPresented: Bool
    // message body
    let body: String
    // message recipient
    let recipient: String
    let completionHandler: (MessageComposeResult) -> Void

    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let controller = MFMessageComposeViewController()
        controller.body = body
        controller.recipients = [recipient]
        controller.messageComposeDelegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        let parent: MessageComposeViewController

        init(parent: MessageComposeViewController) {
            self.parent = parent
        }

        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            parent.isPresented = false
            parent.completionHandler(result)
        }
    }
}
