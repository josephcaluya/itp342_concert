//
//  ConcertPage.swift
//  ConcertConnect
//
//  Created by Joseph Caluya on 4/28/24.
//

import SwiftUI
import EventKitUI
import MessageUI
import UIKit

struct ConcertPage: View {
    @State var showEvent: Bool = false
    @State var showMessage: Bool = false
    @EnvironmentObject var concertViewModel : ConcertViewModel
    
    let event: Event
    
    
    var body: some View {
        VStack {
            // show event name and genre
            Text(event.name)
                .font(.title)
                .padding()
            Text(event.classifications?.first?.genre.name ?? "")
            // make sure image is there; else, use blank placeholder
            if let imageURL = event.images.first?.url,
               let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 240, height: 180)
                .clipShape(.rect(cornerRadius: 25))
                .padding()
            } else {
                Color.gray
                    .frame(width: 240, height: 180)
                    .clipShape(.rect(cornerRadius: 25))
                    .padding()
            }
            // show concert info
            Text("Date: \(event.dates.start.localDate)")
            Text("Venue: \(event._embedded.venues.first?.name ?? "")")
                .padding()
            Text("Location: \(event._embedded.venues.first?.city.name ?? "")")
            
            // lets users add to calendar
            Button("Add to Calendar") {
              self.showEvent.toggle()
            }
            .sheet(isPresented: $showEvent, content: {
                EventEditViewController(event: self.event)
            })
            .padding()
            
            // lets users send message
            Button("Send Message") {
                showMessage = true
            }
            .sheet(isPresented: $showMessage) {
                MessageComposeViewController(isPresented: $showMessage, body: "Hey! Would you be interested in going to the \(event.name) concert? Check it out: \(event.url ?? "ticketmaster.com")", recipient: "+17029783320") {
                    result in
                    switch result {
                    case .cancelled:
                        print("Message sending cancelled")
                    case .sent:
                        print("Message sent successfully")
                    case .failed:
                        print("Message sending failed")
                    @unknown default:
                        fatalError("Unhandled case")
                    }
                }
            }
            
            // lets users see the ticketmaster page
            Button("View on Ticketmaster") {
                guard let url = URL(string: event.url ?? "ticketmaster.com") else { return }
                UIApplication.shared.open(url)
            }
            .padding()
        }
        .padding()
        .background(Color(red: 187.0/255.0, green: 209.0/255.0, blue: 234.0))
    }
}

#Preview {
    ConcertPage(event: Event(name: "Imagine Dragons: Loom World Tour", type: "", id: "123", url: "https://www.ticketmaster.com/imagine-dragons-loom-world-tour-hollywood-california-10-22-2024/event/0B006092C2842706", locale: "en-us", images: [], sales: Sales(publicSales: PublicSales(startDateTime: "", startTBD: false, endDateTime: "")), dates: Dates(start: Start(localDate: "", dateTBD: false, dateTBA: false, timeTBA: false, noSpecificTime: false), timezone: "", status: Status(code: "")), classifications: [], promoter: Promoter(id: ""), _links: EventLinks(linksSelf: SelfElement(href: ""), attractions: [], venues: []), _embedded: EventEmbedded(venues: [], attractions: [])))
        .environmentObject(ConcertViewModel())
}
