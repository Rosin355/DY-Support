//
//  ConversationView.swift
//  Telar
//
//  Created by Romesh Singhabahu on 26/08/22.
//

import SwiftUI

struct ConversationView: View {
    // MARK: - PROPERTIES
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var isChatSwowing: Bool
    
    @State var chatMessage = ""
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            
            // Chat header
            HStack {
                VStack(alignment: .leading) {
                    // Back arrow
                    Button {
                        // Close the window
                        isChatSwowing = false
                    } label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color("text-header"))
                    }
                    .padding(.bottom, 16)

                    // Name
                    Text("Romesh Singhabahu")
                        .font(Font.chatHeading)
                        .foregroundColor(Color("text-header"))
                    
                } // VSTACK
                
                
                Spacer()
                
                // Profile image
                ProfilePicView(user: User())
                
            } // HSTACK
            .frame(height: 104)
            .padding(.horizontal)
            
            // Chat log
            ScrollView {
                
                VStack (spacing: 24){
                    
                    ForEach (chatViewModel.messages) { msg in
                        
                        let isFromUser = msg.senderid == AuthViewModel.getLoggedInUserId()
                        
                        // Dynamic message
                        HStack {
                            
                            if isFromUser {
                                // Timestamp
                                Text("9:41")
                                    .font(Font.smallText)
                                    .foregroundColor(Color("text-timestamp"))
                                    .padding(.trailing)
                                
                                Spacer()
                            }
                            
                            // Message
                            Text(msg.msg)
                                .font(Font.bodyParagraph)
                                .foregroundColor(isFromUser ? Color("text-button") : Color("text-primary"))
                                .padding(.vertical, 16)
                                .padding(.horizontal, 24)
                                .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                                .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                            
                            if !isFromUser {
                                
                                Spacer()
                                
                                Text("9:41")
                                    .font(Font.smallText)
                                    .foregroundColor(Color("text-timestamp"))
                                    .padding(.leading)
                            }
                            
                        }
                    } // HSTACK

                } // VSTACK
                .padding(.horizontal)
                .padding(.top, 24)
            }
            .background(Color("background"))
            
            // Chat message bar
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                
                HStack(spacing: 15) {
                    // Camera button
                    Button {
                        
                        // TODO: Clean up text msg
                        
                        // Send message
                        chatViewModel.sendMessage(msg: chatMessage)
                        
                        // Clear textbox
                        chatMessage = ""
                        
                    } label: {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-secondary"))
                    }

                    // TextField
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color("date-pill"))
                            .cornerRadius(56)
                        
                        TextField("Type something", text: $chatMessage)
                            .foregroundColor(Color("text-input"))
                            .font(Font.bodyParagraph)
                            .padding(10)
                        
                        // Emoji button
                        HStack {
                            Spacer()
                            Button {
                                // TODO: Emoji image
                            } label: {
                                Image(systemName: "face.smiling")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color("text-input"))
                            }
                        } // Hstack
                        .padding(.trailing, 12)
                        
                    } // ZSTACk
                    .frame(height: 44)
                    // Send button
                    Button {
                        // TODO: Send message
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-primary"))
                    }

                } // HSTACK
                .padding(.horizontal)
            } // ZSTACK
            .frame(height: 76)
            
        } // VSATCK
        .onAppear {
            // Call chat view model to retrieve all chat messages
            chatViewModel.getMessages()
        }
    }
}

// MARK: - PREVIEWS
struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatSwowing: .constant(false))
    }
}
