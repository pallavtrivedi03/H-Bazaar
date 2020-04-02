//
//  NetworkManager.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 02/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    func getProducts(completion: @escaping (ProductsAPIResponse?) -> ()) {
        
    }
}
