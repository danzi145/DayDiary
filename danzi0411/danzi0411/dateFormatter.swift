//
//  dateFormatter.swift
//  danzi0411
//
//  Created by 박채운 on 2023/04/11.
//
enum DateFormatType {
    case full
    case year
    case utc
    case utcWithSlash
    
    var description: String {
        switch self {
        case .full:
            return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        case .year:
            return "yyyy-MM-dd"
        case .utc:
            return "MM-dd-yyyy"
        case .utcWithSlash:
            return "MM/dd/yyyy"
        }
    }
}
import UIKit

extension String {
    
    func toDate(to type: DateFormatType) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = type.description
        return dateFormatter.date(from: self)
    }
}

