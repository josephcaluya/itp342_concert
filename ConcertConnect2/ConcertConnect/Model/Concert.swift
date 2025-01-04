//
//  Concert.swift
//  ConcertConnect
//
//  Created by Joseph Caluya on 4/28/24.
//

import Foundation

struct TicketmasterResponse: Codable {
    let _links: Links
    let _embedded: Embedded
    let page: Page
}

struct Links: Codable {
    let linksSelf: Next
    let next: Next?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case next
    }
}

struct Next: Codable {
    let href: String
    let templated: Bool?
}

struct Embedded: Codable {
    let events: [Event]
}

struct Event: Codable, Identifiable {
    let name: String
    let type: String
    let id: String
    let url: String?
    let locale: String
    let images: [ConcertImage]
    let sales: Sales?
    let dates: Dates
    let classifications: [Classification]?
    let promoter: Promoter?
    let _links: EventLinks
    let _embedded: EventEmbedded
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case id
        case url
        case locale
        case images = "images"
        case sales
        case dates
        case classifications
        case promoter
        case _links
        case _embedded
    }
}

struct EventLinks: Codable {
    let linksSelf: SelfElement
    let attractions: [SelfElement]?
    let venues: [SelfElement]?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case attractions, venues
    }
}

struct ConcertImage: Codable {
    let ratio: Ratio?
    let url: String
    let width: Int
    let height: Int
    let fallback: Bool
}

enum Ratio: String, Codable {
    case the16_9 = "16_9"
    case the3_2 = "3_2"
    case the4_3 = "4_3"
}

struct Sales: Codable {
    let publicSales: PublicSales

    enum CodingKeys: String, CodingKey {
        case publicSales = "public"
    }
}

struct PublicSales: Codable {
    let startDateTime: String
    let startTBD: Bool
    let endDateTime: String
}

struct Dates: Codable {
    let start: Start
    let timezone: String?
    let status: Status
}

struct Start: Codable {
    let localDate: String
    let dateTBD: Bool
    let dateTBA: Bool
    let timeTBA: Bool
    let noSpecificTime: Bool
}

struct Status: Codable {
    let code: String
}

struct EventEmbedded: Codable {
    let venues: [Venue]
    let attractions: [Attraction]?
}

struct Classification: Codable {
    let primary: Bool
    let segment, genre, subGenre: Genre
}

struct Genre: Codable {
    let id, name: String
}

struct Promoter: Codable {
    let id: String
}

struct Venue: Codable {
    let name, type, id: String
    let test: Bool
    let locale, postalCode, timezone: String
    let city: City
    let country: Country
    let address: Address
    let location: Location
    let state: USState?
    let markets: [Promoter]?
    let _links: AttractionLinks
    
    enum CodingKeys: String, CodingKey {
        case name, type, id, test, locale, postalCode, timezone
        case city, country, address, location, markets, _links
        case state = "USState"  // Map the JSON key "State" to the property name "USState"
    }

}

struct Attraction: Codable {
    let name, type, id: String
    let test: Bool
    let locale: String
    let images: [ConcertImage]
    let classifications: [Classification]
    let _links: AttractionLinks

    enum CodingKeys: String, CodingKey {
        case name, type, id, test, locale, images, classifications, _links
    }
}

struct AttractionLinks: Codable {
    let linksSelf: SelfElement

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

struct SelfElement: Codable {
    let href: String
}

struct Address: Codable {
    let line1: String
}

struct City: Codable {
    let name: String
}

struct Country: Codable {
    let name, countryCode: String
}

struct Location: Codable {
    let longitude, latitude: String
}

struct USState: Codable {
    let name, stateCode: String
}

struct Page: Codable {
    let size, totalElements, totalPages, number: Int
}
