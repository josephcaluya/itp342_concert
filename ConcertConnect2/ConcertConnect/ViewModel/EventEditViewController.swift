//
//  EventEditViewController.swift
//  ConcertConnect
//
//  Created by Joseph Caluya on 4/30/24.
//
import SwiftUI
import EventKitUI
struct EventEditViewController: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    let event: Event
    let store = EKEventStore()
    var ekevent: EKEvent {
        let ekevent = EKEvent(eventStore: store)
        ekevent.title = event.name
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        ekevent.startDate = formatter.date(from: event.dates.start.localDate)
        ekevent.endDate = formatter.date(from: event.dates.start.localDate)
        return ekevent
    }
    typealias UIViewControllerType = EKEventEditViewController
    func makeUIViewController(context: Context) -> EKEventEditViewController {
       let eventEditViewController = EKEventEditViewController()
        eventEditViewController.event = ekevent
        eventEditViewController.eventStore = store
        eventEditViewController.editViewDelegate = context.coordinator
        return eventEditViewController
    }
    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) {}
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    class Coordinator: NSObject, EKEventEditViewDelegate {
        func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
            
        }
        
        var parent: EventEditViewController
        
        init(_ controller: EventEditViewController) {
            self.parent = controller
        }
        
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
