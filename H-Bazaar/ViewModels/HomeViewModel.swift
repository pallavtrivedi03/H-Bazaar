//
//  HomeViewModel.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 02/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

class HomeViewModel {
        
    var categories: [Category]! {
        didSet {
            parentCategories = categories.filter{ $0.childCategories?.count ?? 0 > 0}
            if let reloadBlock = reload {
                reloadBlock()
            }
        }
    }
    
    var parentCategories: [Category]!
    var rankings: [Ranking]!
    var rankedProducts: [Product]! {
        didSet {
            print("Ranked products count \(rankedProducts!.count)")
        }
    }
    
    var reload: (() -> Void)? = nil

    var fetchTryCount = 0
    
    func getProductsForRanking(rank: String) {
        let products = rankings[rankings.firstIndex{$0.ranking == rank} ?? 0].products
        self.rankedProducts = products?.allObjects as? [Product]
    }
    
    func fetchDataFromDB() {
        let fetchedData = CoreDataManager.shared.fetchProducts()
        if (fetchedData.0.count == 0 || fetchedData.1.count == 0), fetchTryCount < AppConstants.Config.fetchRetriesLimit {
            fetchTryCount += 1
            fetchDataFromAPI()
        } else if fetchTryCount == AppConstants.Config.fetchRetriesLimit {
            //TODO: send callback to view for error
        } else {
            self.categories = fetchedData.0
            self.rankings = fetchedData.1
        }
    }
    
    func fetchDataFromAPI() {
        weak var weakSelf = self
        NetworkManager.shared.getProducts { (productsResponse) in
            if let productsData = productsResponse {
                weakSelf?.saveDataToDB(productsData: productsData)
            } else {
                //TODO: send callback to view for error
            }
        }
        
    }
    
    func saveDataToDB(productsData: ProductsAPIResponseModel) {
        CoreDataManager.shared.saveProducts(productsData: productsData, completion: { [weak self] in
            self?.fetchDataFromDB()
        })
    }
}
