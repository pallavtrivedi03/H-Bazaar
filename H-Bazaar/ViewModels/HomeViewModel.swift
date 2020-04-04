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
            setParentCategories()
        }
    }
    
    var parentCategories: [Category]!
    var rankings: [Ranking]!
    var rankedProducts: [Product]! 
    
    var reload: (() -> Void)? = nil
    var error: ((HBError) -> Void)? = nil
    
    var fetchTryCount = 0
    
    func getProductsForRanking(rank: String) {
        let products = rankings[rankings.firstIndex{$0.ranking == rank} ?? 0].products
        self.rankedProducts = products?.allObjects as? [Product]
    }
    
    func setParentCategories() {
        parentCategories = categories.filter{ $0.childCategories?.count ?? 0 > 0}
        var childCategories = [Int16]()
        for parentCategory in parentCategories {
            let children = (parentCategory.childCategories?.allObjects as! [ChildCategory]).map { (child) -> Int16 in
                return child.id
            }
            childCategories.append(contentsOf: children)
        }
        parentCategories = parentCategories.filter{ !childCategories.contains($0.id)}
        if let reloadBlock = reload {
            reloadBlock()
        }
    }
    
    func fetchDataFromDB() {
        let fetchedData = CoreDataManager.shared.fetchProducts()
        if (fetchedData.0.count == 0 || fetchedData.1.count == 0), fetchTryCount < AppConstants.Config.fetchRetriesLimit {
            fetchTryCount += 1
            fetchDataFromAPI()
        } else if fetchTryCount == AppConstants.Config.fetchRetriesLimit {
            if let errorBlock = error {
                errorBlock(HBError.retriesExhausted)
            }
        } else {
            self.categories = fetchedData.0
            self.rankings = fetchedData.1
            self.rankings.sort{ ($0.ranking ?? "") < ($1.ranking ?? "")}
        }
    }
    
    func fetchDataFromAPI() {
        weak var weakSelf = self
        NetworkManager.shared.getProducts { (productsResponse) in
            if let productsData = productsResponse {
                weakSelf?.saveDataToDB(productsData: productsData)
            } else {
                if let errorBlock = weakSelf?.error {
                    errorBlock(HBError.parsingFailed)
                }
            }
        }
        
    }
    
    func saveDataToDB(productsData: ProductsAPIResponseModel) {
        CoreDataManager.shared.saveProducts(productsData: productsData, completion: { [weak self] in
            self?.fetchDataFromDB()
        })
    }
}
