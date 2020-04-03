//
//  AppConstants.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 02/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

struct AppConstants {
    struct API {
        static let products             = "https://stark-spire-93433.herokuapp.com/json"
    }
    
    struct ViewIdentifiers {
        static let movieCell            = "MovieTableViewCell"
    }
    
    struct Config {
        static let fetchRetriesLimit    = 3
    }
}
