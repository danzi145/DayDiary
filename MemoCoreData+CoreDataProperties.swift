//
//  MemoCoreData+CoreDataProperties.swift
//  
//
//  Created by 박채운 on 2023/05/27.
//
//

import Foundation
import CoreData


extension MemoCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoCoreData> {
        return NSFetchRequest<MemoCoreData>(entityName: "MemoCoreData")
    }

    @NSManaged public var mTitle: String?
    @NSManaged public var mDate: Date?
    @NSManaged public var mContent: String?

}
