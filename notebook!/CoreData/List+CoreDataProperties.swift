//
//  List+CoreDataProperties.swift
//  notebook!
//
//  Created by Nurbakhyt on 11.08.2023.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?

}

extension List : Identifiable {

}
