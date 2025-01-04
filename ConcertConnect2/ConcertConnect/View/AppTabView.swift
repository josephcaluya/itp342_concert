//
//  AppTabView.swift
//  ConcertConnect
//
//  Created by Joseph Caluya on 4/28/24.
//

import SwiftUI

struct AppTabView: View {
    @StateObject var concertViewModel = ConcertViewModel()
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Label ("Search", systemImage: "magnifyingglass.circle.fill")
                }
            MapView()
                .tabItem {
                    Label ("Map", systemImage: "mappin.and.ellipse")
                }
        }
        .environmentObject(concertViewModel)
    }
}

#Preview {
    AppTabView()
        .environmentObject(ConcertViewModel())
}
