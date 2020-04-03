//
//  Variant+CoreDataProperties.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 03/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//
//

import Foundation
import CoreData


extension Variant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Variant> {
        return NSFetchRequest<Variant>(entityName: "Variant")
    }

    @NSManaged public var color: String?
    @NSManaged public var id: Int16
    @NSManaged public var price: Int16
    @NSManaged public var size: Int16
    @NSManaged public var product: Product?

}
