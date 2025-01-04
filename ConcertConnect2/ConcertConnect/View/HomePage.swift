//
//  HomePage.swift
//  ConcertConnect
//
//  Created by Joseph Caluya on 4/28/24.
//

import SwiftUI

struct HomePage: View {
    @State var term = ""
    var body: some View {
        NavigationStack {
            VStack(spacing: 12.0) {
                Spacer()
                Text("Welcome to Concert Connect!")
                    .font(.title)
                Text("Search for a concert using the field below.")
                Image("mic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                TextField("Enter artist", text: $term)
                    .padding()
                    .background(Color.white)
                    .frame(width: 320)
                    .keyboardType(.asciiCapable)
                // queries user's search to then show results page
                NavigationLink(destination: ConcertList(searchTerm: term)) {
                    Label("Search", systemImage: "magnifyingglass")
                }
                Spacer()
            }
            .background(Color(red: 187.0/255.0, green: 209.0/255.0, blue: 234.0))
            .padding()
        }
    }
}

#Preview {
    HomePage()
}
