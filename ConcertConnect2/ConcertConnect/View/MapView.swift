//
//  MapView.swift
//  ConcertConnect
//
//  Created by Joseph Caluya on 4/28/24.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct MapView: View {
    @State var searchText: String = ""
    @State var selectedPlace: GMSPlace?
    @State var showAutoComplete = false
    
    var body: some View {
        ZStack {
            if showAutoComplete {
                // show search bar only when textfield is pressed
                MapAutoComplete(selectedPlace: $selectedPlace, searchText: $searchText, showAutoComplete: $showAutoComplete)
                    .edgesIgnoringSafeArea(.all)
            } else {
                MapPage(searchText: $searchText, selectedPlace: $selectedPlace)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 450)
            }
                    
            if !showAutoComplete {
                VStack {
                    // hide when search bar is displayed
                    Text("Search for Venues")
                        .font(.title)
                        .padding()
                    TextField("Search", text: $searchText, onEditingChanged: { changed in
                        if changed {
                            showAutoComplete = true
                        }
                    })
                    .padding()
                    Spacer()
                }
                .opacity(showAutoComplete ? 0 : 1)
            }
        }
    }
    
}

#Preview {
    MapView()
}
