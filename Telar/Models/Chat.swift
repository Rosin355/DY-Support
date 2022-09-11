//
//  Chat.swift
//  Telar
//
//  Created by Romesh Singhabahu on 27/08/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Chat: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var numberparticipants: Int
    var participants: [String]
    var lastmsg: String?
    
    @ServerTimestamp var updated: Date?
    
    var msgs: [ChatMessage]?
}

struct ChatMessage: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var imageurl: String?
    var msg: String
    
    @ServerTimestamp var timestamp: Date?
    
    var senderid: String
}
