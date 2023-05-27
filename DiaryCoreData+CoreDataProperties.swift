//
//  DiaryCoreData+CoreDataProperties.swift
//  
//
//  Created by 박채운 on 2023/05/27.
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
    @NSManaged public var dCapsule: Date?
    
    
//    var dateString: String? {
//        let myFormatter = DateFormatter()
//        myFormatter.dateFormat = "yyyy-MM-dd"
//        guard let date = self.dDate else { return "" }
//        let savedDateString = myFormatter.string(from: date)
//        return savedDateString
//
//
//    }
}
extension DiaryCoreData : Identifiable {

}

