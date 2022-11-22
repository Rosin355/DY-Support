//
//  ChatsListView.swift
//  Telar
//
//  Created by Romesh Singhabahu on 17/08/22.
//

import SwiftUI

struct ChatsListView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var isChatShowing: Bool
    
    var body: some View {
        
        VStack {
            // Heading
            HStack {
                Text("Chats")
                    .font(Font.pageTitle)
                
                Spacer()
                
                Button {
                    // TODO: Settings
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icons-secondary"))
                }
            } // HSTACK
            .padding(.top, 20)
            .padding(.horizontal)
            
            // Chat List
            
            if chatViewModel.chats.count > 0 {
                
                List(chatViewModel.chats) { chat in
                    
                    Button {
                        
                        // Set selcted chat for the chatviewmodel
                        chatViewModel.selectedChat = chat
                        
                        // display conversation view
                        isChatShowing = true
                        
                    } label: {
                        ChatListRow(chat: chat,
                                    otherParticipants: contactsViewModel.getParticipants(ids: chat.participantids))
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                
            }
            else {
                Spacer()
                
                Image("no-chats-yet")
                
                Text("Hmm... Non hai messaggi?")
                    .font(Font.titleText)
                    .padding(.top, 32)
                
                Text("Incomincia a chattare con un amico!")
                    .font(Font.bodyParagraph)
                    .padding(.top, 8)
                
                
                Spacer()
            }
        } // VSTACK
       
        
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView(isChatShowing: .constant(false))
    }
}
