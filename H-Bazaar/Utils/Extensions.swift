//
//  Extensions.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 04/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//
import UIKit
import Foundation

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 0.5)
    }
    
    static var randomDark: UIColor {
           return UIColor(red: .random(in: 0...1),
                          green: .random(in: 0...1),
                          blue: .random(in: 0...1),
                          alpha: 1)
       }
}
