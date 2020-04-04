//
//  HomeViewNavigator.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 04/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

protocol IHomeViewNavigator {
    init(homeView: HomeViewController)
    func showCategoryDetailView(categoryView: CategoryDetailViewController)
}

class HomeViewNavigator: IHomeViewNavigator {
    
    unowned var homeView: HomeViewController
    
    required init(homeView: HomeViewController) {
        self.homeView = homeView
    }
    
    func showCategoryDetailView(categoryView: CategoryDetailViewController) {
        self.homeView.navigationController?.pushViewController(categoryView, animated: true)
    }    
}
