//
//  ConcertList.swift
//  ConcertConnect
//
//  Created by Joseph Caluya on 4/28/24.
//

import SwiftUI

struct ConcertList: View {
    let searchTerm: String
    @StateObject var concertViewModel = ConcertViewModel()
    @State var viewDidLoad : Bool = false
    var body: some View {
        Text("Results")
            .font(.title)
            .bold()
            .padding()
        ScrollView(.vertical) {
            NavigationView {
                // loop through all results
                LazyVStack {
                    ForEach(concertViewModel.events) { event in
                        NavigationLink(destination: ConcertPage(event: event)) {
                            ConcertCell(event: event)
                        }
                        Divider()
                    }
                }
                .task {
                    if !viewDidLoad {
                        await concertViewModel.fetch(term: searchTerm)
                        viewDidLoad = true
                    }
                }
            }
        }
    }
}

#Preview {
    ConcertList(searchTerm: "Imagine Dragons")
}
