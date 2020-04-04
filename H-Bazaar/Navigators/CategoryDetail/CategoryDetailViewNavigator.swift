//
//  CategoryDetailViewNavigator.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 04/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//
import UIKit
import Foundation

protocol ICategoryDetailViewNavigator {
    init(navigator: UINavigationController?)
    func showProductDetailView(product: Product)
}

class CategoryDetailViewNavigator: ICategoryDetailViewNavigator {
    
    weak var navigator: UINavigationController?
    
    required init(navigator: UINavigationController?) {
        self.navigator = navigator
    }
    
    func showProductDetailView(product: Product) {
        if let productDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: AppConstants.ViewIdentifiers.productDetailVC) as? ProductDetailViewController {
            productDetailVC.productDetailViewModel.product = product
            self.navigator?.pushViewController(productDetailVC, animated: true)
        }
    }
}
