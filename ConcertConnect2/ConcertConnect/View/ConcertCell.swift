//
//  ConcertCell.swift
//  ConcertConnect
//
//  Created by Joseph Caluya on 4/28/24.
//

import SwiftUI

struct ConcertCell: View {
    let event: Event
    var body: some View {
        HStack (spacing: 12.0) {
            if let imageURL = event.images.first?.url,
               let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 140, height: 110)
                .clipShape(.rect(cornerRadius: 25))
                .padding()
            } else {
                // show placeholder if no image is available
                Color.gray
                    .frame(width: 140, height: 110)
                    .clipShape(.rect(cornerRadius: 25))
                    .padding()
            }
            Text(event.name)
                .font(.headline)
        }
        .padding()
    }
}

#Preview {
    ConcertCell(event: Event(name: "Imagine Dragons: Loom World Tour", type: "", id: "123", url: "https://www.ticketmaster.com/imagine-dragons-loom-world-tour-hollywood-california-10-22-2024/event/0B006092C2842706", locale: "en-us", images: [], sales: Sales(publicSales: PublicSales(startDateTime: "", startTBD: false, endDateTime: "")), dates: Dates(start: Start(localDate: "", dateTBD: false, dateTBA: false, timeTBA: false, noSpecificTime: false), timezone: "", status: Status(code: "")), classifications: [], promoter: Promoter(id: ""), _links: EventLinks(linksSelf: SelfElement(href: ""), attractions: [], venues: []), _embedded: EventEmbedded(venues: [], attractions: [])))
}
