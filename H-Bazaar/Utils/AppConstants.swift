//
//  AppConstants.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 02/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//
import UIKit
import Foundation

struct AppConstants {
    struct API {
        static let products             = "https://stark-spire-93433.herokuapp.com/json"
    }
    
    struct ViewIdentifiers {
        static let rankingHeaderCell        = "RankingHeaderCollectionViewCell"
        static let categoriesHeaderView     = "CategoriesHeaderView"
    }
    
    struct Config {
        static let fetchRetriesLimit    = 3
    }
    
    struct ViewFrames {
        struct Height {
            static let rankingHeader    = 72
            static let categoriesHeader = 300
        }
        struct Width {
            static let rankingHeader    = 160
            static let categoriesHeader = UIScreen.main.bounds.size.width
        }
    }
}
