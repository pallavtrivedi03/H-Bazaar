//
//  CategoryDetailViewNavigator.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 04/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

protocol ICategoryDetailViewNavigator {
    init(categoryView: CategoryDetailViewController)
    func showProductDetailView(productDetailView: ProductDetailViewController)
}

class CategoryDetailViewNavigator: ICategoryDetailViewNavigator {
    
    unowned var categoryDetailView: CategoryDetailViewController
    
    required init(categoryView: CategoryDetailViewController) {
        self.categoryDetailView = categoryView
    }
    
    func showProductDetailView(productDetailView: ProductDetailViewController) {
        self.categoryDetailView.navigationController?.pushViewController(productDetailView, animated: true)
    }
}
