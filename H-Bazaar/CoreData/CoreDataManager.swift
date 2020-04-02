//
//  CoreDataManager.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 02/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {
        
    }
    
    func saveProducts(productsData: ProductsAPIResponseModel) {
        prepareDataForDB(productsData: productsData)
        saveContext()
    }
    
    private func prepareDataForDB(productsData: ProductsAPIResponseModel) {
        if let categoriesResponse = productsData.categories, categoriesResponse.count > 0 {
            for categoryResponse in categoriesResponse {
                _ = createEntity(categoryResponse: categoryResponse)
            }
            print("processed all categories")
        }
        
        if let rankings = productsData.rankings, rankings.count > 0 {
            _ = createEntity(rankingsResponse: rankings)
            print("processed all rankings")
        }
    }
    
    private func createEntity(categoryResponse: CategoriesResponseModel) -> Category {
        let category = Category(context: self.managedObjectContext)
        category.id = Int16(categoryResponse.id ?? 0)
        category.name = categoryResponse.name
        
        let products = createEntity(productsResponse: categoryResponse.products)
        category.products = NSSet(array: products)
        category.childCategories = NSSet(array: createEntity(childCategoryResponse: categoryResponse.childCategories))
        
        return category
    }
    
    private func createEntity(productsResponse: [ProductResponseModel]?) -> [Product] {
        var products = [Product]()
        guard let productsResponseArray = productsResponse else { return products }
        
        for productResponse in productsResponseArray {
            let product = Product(context: self.managedObjectContext)
            product.id = Int16(productResponse.id ?? 0)
            product.name = productResponse.name ?? ""
            product.dateAdded = Helper.getDate(from: productResponse.date_added ?? "")
            
            let variants = createEntity(variantsResponse: productResponse.variants)
            product.variants = NSSet(array: variants)
            
            if let taxResponse = productResponse.tax {
                product.tax = createEntity(taxResponse: taxResponse)
            }
            
            products.append(product)
        }
        
        
        return products
    }
    
    private func createEntity(variantsResponse: [VariantsResponseModel]?) -> [Variant] {
        var variants = [Variant]()
        guard let variantResponseArray = variantsResponse else { return variants }
        
        for variantResponse in variantResponseArray {
            let variant = Variant(context: self.managedObjectContext)
            variant.id = Int16(variantResponse.id ?? 0)
            variant.size = Int16(variantResponse.size ?? 0)
            variant.color = variantResponse.color ?? ""
            
            variants.append(variant)
        }
        
        return variants
    }
    
    private func createEntity(taxResponse: TaxResponseModel) -> Tax {
        let tax = Tax(context: self.managedObjectContext)
        tax.name = taxResponse.name ?? ""
        tax.value = taxResponse.value ?? 0.0
        return tax
    }
    
    private func createEntity(childCategoryResponse: [Int]?) -> [ChildCategory] {
        var childCategoriesArray = [ChildCategory]()
        
        if let childCategories = childCategoryResponse {
            for child in childCategories {
                let childCategory = ChildCategory(context: self.managedObjectContext)
                childCategory.id = Int16(child)
                childCategoriesArray.append(childCategory)
            }
        }
        return childCategoriesArray
    }
    
    private func createEntity(productViewsResponse: [ProductViewsResponseModel]?) -> [ProductViews] {
        
        var productViews = [ProductViews]()
        if let productViewsArray = productViewsResponse {
            for productViewResponse in productViewsArray {
                let productView = ProductViews(context: self.managedObjectContext)
                productView.id = Int16(productViewResponse.id ?? 0)
                productView.viewCount = Int64(productViewResponse.viewCount ?? 0)
                productViews.append(productView)
            }
        }
        return productViews
    }
    
    private func createEntity(rankingsResponse: [RankingsResponseModel]?) -> [Ranking] {
        var rankings = [Ranking]()
        
        if let rankingsArray = rankingsResponse {
            for rankingResponse in rankingsArray {
                let ranking = Ranking(context: self.managedObjectContext)
                ranking.ranking = rankingResponse.ranking ?? ""
                ranking.products = NSSet(array: createEntity(productViewsResponse: rankingResponse.products))
                rankings.append(ranking)
            }
        }
        return rankings
    }
    
    // MARK: - Core Data stack
    
    private lazy var managedObjectContext = {
        
        return self.persistentContainer.viewContext
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "H_Bazaar")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
