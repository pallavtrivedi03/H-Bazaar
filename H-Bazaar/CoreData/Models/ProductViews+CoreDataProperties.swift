//
//  ProductViews+CoreDataProperties.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 02/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductViews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductViews> {
        return NSFetchRequest<ProductViews>(entityName: "ProductViews")
    }

    @NSManaged public var id: Int16
    @NSManaged public var viewCount: Int64
    @NSManaged public var ranking: Ranking?

}
