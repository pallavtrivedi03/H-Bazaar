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
        static let productCell              = "ProductCollectionViewCell"
        static let rankingHeaderCell        = "RankingHeaderCollectionViewCell"
        static let categoriesHeaderView     = "CategoriesHeaderView"
        static let categoryTableViewCell    = "CategoryTableViewCell"
        static let categoryCollectionCell   = "CategoryCollectionViewCell"
    }
    
    struct Config {
        static let fetchRetriesLimit    = 3
    }
    
    struct ViewFrames {
        struct Height {
            static let rankingHeader    = 72
            static let categoriesHeader = 300
            static let product          = 220
            static let categoryCell     = 80
        }
        struct Width {
            static let rankingHeader    = 160
            static let categoriesHeader = UIScreen.main.bounds.size.width
            static let product          = 160
            static let categoryCell     = (UIScreen.main.bounds.size.width - 24)/2
        }
    }
}
