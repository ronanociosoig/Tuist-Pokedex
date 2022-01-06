//
//  Constants.swift
//  Common
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

// swiftlint:disable nesting identifier_name

public struct Constants {
    
    public struct Network {
        public static let baseUrlPath = "https://pokeapi.co/api/v2/"
        public static let searchPath = "pokemon"
    }
    
    public struct Image {
        public static let pokemonPlaceholder = "PokemonPlaceholder"
    }
    
    public struct Translations {
        public static let loading = "Loading"
        public static let ok = "OK"
        public static let cancel = "Cancel"
        
        public struct HomeScene {
            public static let catchTitle = "Catch a Pokemon"
        }
        
        public struct CatchScene {
            public static let weight = "WEIGHT"
            public static let height = "HEIGHT"
            public static let leaveOrCatchAlertMessageTitle = "Do you want to leave it or catch it?"
            public static let leaveItButtonTitle = "Leave it"
            public static let catchItButtonTitle = "Catch it!"
            public static let alreadyHaveItAlertMessageTitle = "You have already caught one of this species, you'll have to leave this one..."
            
            public static let noPokemonFoundAlertTitle = "No Pokemon found, you will have to try again."
        }
        
        public struct BackpackScene {
            public static let title = "Backpack"
            public static let closeButton = "Close"
        }
        
        public struct DetailScene {
            public static let weight = "Weight"
            public static let height = "Height"
            public static let date = "Date"
            public static let experience = "Experience"
            public static let types = "Types"
        }
        
        public struct Error {
            public static let jsonDecodingError = "Error: JSON decoding error."
            public static let noDataError = "Error: No data received."
            public static let noResultsFound = "No results were found for your search."
            public static let statusCode404 = "404"
            public static let notFound = "Error 401 Pokemon not found"
            public static let asyncError = "Async Search failed"
        }
    }
    
    public struct PokemonAPI {
        public static let minIdentifier = 1
        public static let maxIdentifier = 1000
    }
}
