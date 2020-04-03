//
//  ChildCategory+CoreDataProperties.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 03/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//
//

import Foundation
import CoreData


extension ChildCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChildCategory> {
        return NSFetchRequest<ChildCategory>(entityName: "ChildCategory")
    }

    @NSManaged public var id: Int16
    @NSManaged public var category: Category?

}
