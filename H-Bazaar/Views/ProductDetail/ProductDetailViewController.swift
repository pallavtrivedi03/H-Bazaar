//
//  ProductDetailViewController.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 04/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import UIKit
import iCarousel

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var variantsContainer: iCarousel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    let productDetailViewModel = ProductDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = productDetailViewModel.product?.name ?? ""
        variantsContainer.isPagingEnabled = true
        variantsContainer.type = .coverFlow
        populateData(index: 0)
    }
    
    func populateData(index: Int) {
        if let variants = productDetailViewModel.product?.variants?.allObjects as? [Variant] {
            let selectedVariant = variants[index]
            titleLabel.text = productDetailViewModel.product?.name ?? ""
            colorLabel.text = selectedVariant.color?.appending(" color")
            if selectedVariant.size == 0 {
                sizeLabel.text = "₹ ".appending("\(selectedVariant.price)")
                priceLabel.text = ""
            } else {
                sizeLabel.text = "Size ".appending("\(selectedVariant.size)")
                priceLabel.text = "₹ ".appending("\(selectedVariant.price)")
            }
        }
        
    }
    
}

extension ProductDetailViewController: iCarouselDelegate, iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        if productDetailViewModel.product != nil {
            return productDetailViewModel.product?.variants?.count ?? 0
        } else {
            return 0
        }
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let variantView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.center = variantView.center
        imageView.image = UIImage(named: "placeholder")
        variantView.addSubview(imageView)
        variantView.layer.cornerRadius = 8
        variantView.clipsToBounds = true
        variantView.backgroundColor = .randomDark
        return variantView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        populateData(index: carousel.currentItemIndex)
    }
}
