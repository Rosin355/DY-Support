//
//  ChatListRow.swift
//  Telar
//
//  Created by Romesh Singhabahu on 24/10/22.
//

import SwiftUI

struct ChatListRow: View {
    // MARK: - PROPERTIES
    
    var chat: Chat
    var otherParticipants: [User]?
    
    // MARK: - BODY
    var body: some View {
        
        HStack (spacing: 24) {
            
            // Assume at least 1 other participate in the chat
            let participant = otherParticipants?.first
            
            // Profile Image of participants
            if participant != nil {
                ProfilePicView(user: participant!)
            }
        
            VStack (alignment: .leading, spacing: 4) {
                // Name
                Text(participant == nil ? "Sconosciuto" :
                    "\(participant!.firstname ?? "") \(participant!.lastname ?? "")")
                    .font(Font.button)
                    .foregroundColor(Color("text-primary"))
                
                // Last Message
                Text(chat.lastmsg ?? "")
                    .font(Font.bodyParagraph)
                    .foregroundColor(Color("text-input"))
            }
            
            // Extra space
            Spacer()
            
            // Timestampe
            Text(chat.updated == nil ? "" : DateHelper.chatTimeStampFrom(date: chat.updated!))
                .font(Font.bodyParagraph)
                .foregroundColor(Color("text-input"))
            
            
        } //VSTACK
    }
}

