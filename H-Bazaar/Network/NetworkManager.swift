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
    
    let webserviceHelper = WebserviceHelper()
    private init() {
        
    }
    
    func getProducts(completion: @escaping (ProductsAPIResponseModel?) -> ()) {
        guard let url = URL(string: AppConstants.API.products)
            else {
                return
        }
        webserviceHelper.fetchData(url: url, shouldCancelOtherOps: true) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(nil)
            } else {
                guard let responseData = data else { return }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let productsResponse = try jsonDecoder.decode(ProductsAPIResponseModel.self, from: responseData)
                    completion(productsResponse)
                } catch {
                    print("Error occured while parsing products response")
                    completion(nil)
                }
            }
        }
    }
}
