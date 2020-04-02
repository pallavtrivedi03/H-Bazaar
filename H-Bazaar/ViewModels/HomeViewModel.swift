//
//  HomeViewModel.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 02/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    
    func getProducts() {
        
        weak var weakSelf = self
        NetworkManager.shared.getProducts { (productsResponse) in
            if let productsData = productsResponse {
                weakSelf?.saveDataToDB(productsData: productsData)
            } else {
                //TODO: send callback to view for error
            }
        }
        
    }
    
    func fetchDataFromDB() {
        let fetchedData = CoreDataManager.shared.fetchProducts()
        if fetchedData.0.count == 0 || fetchedData.1.count == 0 {
            getProducts()
        }
    }
    
    func saveDataToDB(productsData: ProductsAPIResponseModel) {
        CoreDataManager.shared.saveProducts(productsData: productsData)
    }
}
