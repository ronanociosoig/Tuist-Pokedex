//
//  Constants.swift
//  NetworkKit
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

// swiftlint:disable nesting identifier_name

struct Constants {
    
    struct Network {
        static let baseUrlPath = "https://pokeapi.co/api/v2/"
        static let searchPath = "pokemon"
    }
    
    struct Image {
        static let pokemonPlaceholder = "PokemonPlaceholder"
    }
    
    struct Translations {
        static let loading = "Loading"
        static let ok = "OK"
        static let cancel = "Cancel"
        
        struct HomeScene {
            static let catchTitle = "Catch a Pokemon"
        }
        
        struct CatchScene {
            static let weight = "WEIGHT"
            static let height = "HEIGHT"
            static let leaveOrCatchAlertMessageTitle = "Do you want to leave it or catch it?"
            static let leaveItButtonTitle = "Leave it"
            static let catchItButtonTitle = "Catch it!"
            static let alreadyHaveItAlertMessageTitle = "You have already caught one of this species, you'll have to leave this one..."
            
            static let noPokemonFoundAlertTitle = "No Pokemon found, you will have to try again."
            
        }
        
        struct BackpackScene {
            static let title = "Backpack"
            static let closeButton = "Close"
        }
        
        struct DetailScene {
            static let weight = "Weight"
            static let height = "Height"
            static let date = "Date"
            static let experience = "Experience"
            static let types = "Types"
        }
        
        struct Error {
            static let jsonDecodingError = "Error: JSON decoding error."
            static let noDataError = "Error: No data received."
            static let noResultsFound = "No results were found for your search."
            static let statusCode404 = "404"
            static let notFound = "Error 401 Pokemon not found"
        }
    }
    
    struct PokemonAPI {
        static let minIdentifier = 1
        static let maxIdentifier = 1000
    }
}
