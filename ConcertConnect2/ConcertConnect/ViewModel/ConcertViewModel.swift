//
//  ConcertViewModel.swift
//  ConcertConnect
//
//  Created by Joseph Caluya on 4/28/24.
//

import Foundation

class ConcertViewModel : ObservableObject {
    private let BASE_URL: String = "https://app.ticketmaster.com/discovery/v2/events.json"
    private let ACCESS_KEY: String = "tAEvzEjGAmfGSxfEv7DDUlvYCgnbSoGD"
    @Published var isLoading = false
    @Published var events = [Event]()
    func fetch(term: String) async {
        // make sure search is valid and add it to url as a parameter
        let search = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "\(BASE_URL)?apikey=\(ACCESS_KEY)&keyword=\(search)&size=20")!
        isLoading = true
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let ticketmasterResponse = try decoder.decode(TicketmasterResponse.self, from: data)
            // save events to events array
            events = ticketmasterResponse._embedded.events
        } catch {
            print(error)
        }
        isLoading = false
    }
}

