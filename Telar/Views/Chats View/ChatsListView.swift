//
//  ChatsListView.swift
//  Telar
//
//  Created by Romesh Singhabahu on 17/08/22.
//

import SwiftUI

struct ChatsListView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var isChatShowing: Bool
    
    var body: some View {
        
        if chatViewModel.chats.count > 0 {
            
            List(chatViewModel.chats) { chat in
                
                Button {
                    
                    // Set selcted chat for the chatviewmodel
                    chatViewModel.selectedChat = chat
                    
                    // display conversation view
                    isChatShowing = true
                    
                } label: {
                    Text(chat.id ?? "chat id vuoto")
                }
            }
            
        }
        else {
            Text("Non ci sono messaggi")
        }
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView(isChatShowing: .constant(false))
    }
}
