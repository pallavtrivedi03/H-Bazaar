//
//  Product+CoreDataProperties.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 03/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetch() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var dateAdded: Date?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var views: Int64
    @NSManaged public var orders: Int64
    @NSManaged public var shares: Int64
    @NSManaged public var category: Category?
    @NSManaged public var tax: Tax?
    @NSManaged public var variants: NSSet?
    @NSManaged public var ranking: NSSet?

}

// MARK: Generated accessors for variants
extension Product {

    @objc(addVariantsObject:)
    @NSManaged public func addToVariants(_ value: Variant)

    @objc(removeVariantsObject:)
    @NSManaged public func removeFromVariants(_ value: Variant)

    @objc(addVariants:)
    @NSManaged public func addToVariants(_ values: NSSet)

    @objc(removeVariants:)
    @NSManaged public func removeFromVariants(_ values: NSSet)

}

// MARK: Generated accessors for ranking
extension Product {

    @objc(addRankingObject:)
    @NSManaged public func addToRanking(_ value: Ranking)

    @objc(removeRankingObject:)
    @NSManaged public func removeFromRanking(_ value: Ranking)

    @objc(addRanking:)
    @NSManaged public func addToRanking(_ values: NSSet)

    @objc(removeRanking:)
    @NSManaged public func removeFromRanking(_ values: NSSet)

}
