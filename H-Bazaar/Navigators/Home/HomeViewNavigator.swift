//
//  HomeViewNavigator.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 04/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation
import UIKit
protocol IHomeViewNavigator {
    init(navigator: UINavigationController?)
    func showCategoryDetailView(category: Category)
    func showProductDetailView(product: Product)
}

class HomeViewNavigator: IHomeViewNavigator {
    
    weak var navigator: UINavigationController?
    
    required init(navigator: UINavigationController?) {
        self.navigator = navigator
    }
    
    func showCategoryDetailView(category: Category) {
        if let categoryDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: AppConstants.ViewIdentifiers.categoryDetailVC) as? CategoryDetailViewController {
            categoryDetailVC.categoryViewModel.category = category
            self.navigator?.pushViewController(categoryDetailVC, animated: true)
        }
    }
    
    func showProductDetailView(product: Product) {
        if let productDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: AppConstants.ViewIdentifiers.productDetailVC) as? ProductDetailViewController {
            productDetailVC.productDetailViewModel.product = product
            self.navigator?.pushViewController(productDetailVC, animated: true)
        }
    }
}
