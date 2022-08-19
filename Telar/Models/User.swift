//
//  User.swift
//  Telar
//
//  Created by Romesh Singhabahu on 10/08/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var firstname: String?
    var lastname: String?
    var phone: String?
    var photo: String?
    
    
}
