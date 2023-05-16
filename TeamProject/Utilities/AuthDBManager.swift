//
//  AuthDBManager.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/16.
//

import Foundation
import FirebaseDatabase

final class AuthDBManager {
    static let shared = AuthDBManager()
    
    private let database = Database.database().reference()
    
}


//MARK: - Account Management
extension AuthDBManager {
    
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    /// Inserts new user to database
    public func insertUser(with user: DayDiaryAppUser) {
        database.child(user.safeEmail).setValue([
            "email": user.safeEmail
        ])
    }
}

struct DayDiaryAppUser {
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
