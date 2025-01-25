//
//  MapController.swift
//  ConcertConnect
//
//  Created by Joseph Caluya on 4/30/24.
//

import SwiftUI
import UIKit
import GoogleMaps
import GooglePlaces

struct MapPage: UIViewRepresentable {
    @Binding var searchText: String
    @Binding var selectedPlace: GMSPlace?
    
    func makeUIView(context: Context) -> GMSMapView {
        GMSServices.provideAPIKey("AIzaSyBx-QANWFi-CBRMW2kUM8p04BJ3tS_GB7o")
        let options = GMSMapViewOptions()
        options.camera = GMSCameraPosition.camera(withLatitude: 37.7749, longitude: -122.4194, zoom: 12.0)
        let mapView = GMSMapView(options: options)
        mapView.delegate = context.coordinator
        return mapView
    }
    
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        // Update map view
        if let place = selectedPlace {
            let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude,
                                                  longitude: place.coordinate.longitude,
                                                  zoom: 15.0)
            mapView.animate(to: camera)
            let marker = GMSMarker(position: place.coordinate)
            marker.title = selectedPlace?.name
            marker.map = mapView
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: MapPage
        
        init(_ parent: MapPage) {
            self.parent = parent
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            parent.selectedPlace = place
            parent.searchText = place.name ?? ""
            viewController.dismiss(animated: true, completion: nil)
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Autocomplete error: \(error.localizedDescription)")
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}


struct MapAutoComplete: UIViewControllerRepresentable {
    @Binding var selectedPlace: GMSPlace?
    @Binding var searchText: String
    @Binding var showAutoComplete: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        GMSPlacesClient.provideAPIKey("AIzaSyBx-QANWFi-CBRMW2kUM8p04BJ3tS_GB7o")
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
        let filter = GMSAutocompleteFilter()
        filter.types = ["stadium", "bar", "night_club", "movie_theater"]
        autocompleteController.autocompleteFilter = filter
        return autocompleteController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, GMSAutocompleteViewControllerDelegate {
        var parent: MapAutoComplete

        init(_ parent: MapAutoComplete) {
            self.parent = parent
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            parent.selectedPlace = place
            parent.searchText = place.name ?? ""
            parent.searchText = ""
            parent.showAutoComplete = false
            viewController.dismiss(animated: true, completion: nil)
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Autocomplete error: \(error.localizedDescription)")
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent.showAutoComplete = false
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}

