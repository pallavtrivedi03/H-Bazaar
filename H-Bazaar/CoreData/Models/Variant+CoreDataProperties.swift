//
//  Variant+CoreDataProperties.swift
//  
//
//  Created by Pallav Trivedi on 04/04/20.
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
    @NSManaged public var price: Int64
    @NSManaged public var size: Int16
    @NSManaged public var product: Product?

}
