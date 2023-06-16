//
//  DiaryCoreData+CoreDataProperties.swift
//  
//
//  Created by 박채운 on 2023/06/16.
//
//

import Foundation
import CoreData


extension DiaryCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryCoreData> {
        return NSFetchRequest<DiaryCoreData>(entityName: "DiaryCoreData")
    }

    @NSManaged public var dTitle: String?
    @NSManaged public var dContent: String?
    @NSManaged public var dDate: Date?
    @NSManaged public var dPhoto: Data?

}
