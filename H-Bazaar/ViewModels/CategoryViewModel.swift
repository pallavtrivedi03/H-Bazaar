//
//  CategoryViewModel.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 04/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

class CategoryViewModel {
    
    var category: Category? {
        didSet {
            updateChildren(childIndex: 0, grandChild: 0)
        }
    }
    
    var categories: [Category]
    
    var childCategory: Category?
    var grandChildCategory: Category?
    var grandChildren = [Category]()
    
    init() {
        categories = CoreDataManager.shared.fetchProducts().0
    }
    
    func getCategory(id: Int16) -> Category? {
        return categories.first{ $0.id == id} ?? nil
    }
    
    func updateChildren(childIndex: Int, grandChild: Int) {
        guard let childCategoryIndices = category?.childCategories?.allObjects as? [ChildCategory]  else {
            return
        }
        guard let childCat = getCategory(id: childCategoryIndices[childIndex].id) else {
            return
        }
        childCategory = childCat
        guard let grandChildCategoryIndices = childCat.childCategories?.allObjects as? [ChildCategory] else {
            return
        }
        grandChildren.removeAll()
        for index in grandChildCategoryIndices {
            grandChildren.append(getCategory(id: index.id)!)
        }
        
        if let grandChildCat = getCategory(id: grandChildCategoryIndices[grandChild].id) {
            grandChildCategory = grandChildCat
        }
    }
}
