//
//  HomeViewController.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 02/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewModel.getProducts()
    }

}
