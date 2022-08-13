//
//  CustomTabBar.swift
//  Telar
//
//  Created by Romesh Singhabahu on 14/07/22.
//

import SwiftUI

enum Tabs: Int {
    case chats = 0
    case contacts = 1
}

struct CustomTabBar: View {
    // MARK: - PROPERTIES
    @Binding var selectedTab: Tabs
    
    // MARK: - BODY
    var body: some View {
        HStack (alignment: .center) {
            /// BUTTON CHATS
            Button {
                // Switch to chats
                selectedTab = .chats
            } label: {
                
                TabBarButton(buttonText: "Chats",
                             imageName: "bubble.left",
                             isActive: selectedTab == .chats)
            }
            .tint(Color("icons-secondary"))
            
            /// BUTTON NEW CHAT
            Button {
                // TODO: Chage the logout wiuht the actual new chat feature
                AuthViewModel.logout()
                
            } label: {
                
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    
                    Text("New Chat")
                        .font(Font.tabBar)
                }
            }
            .tint(Color("icons-primary"))
            
            /// BUTTON CONTACTS
            Button {
                // Switch to contacts
                selectedTab = .contacts
            } label: {
                
                TabBarButton(buttonText: "Contacts",
                             imageName: "person",
                             isActive: selectedTab == .contacts)
            }
            .tint(Color("icons-secondary"))
        }
        .frame(height: 82)
    }
}

// MARK: - PREVIEWS
struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.contacts))
    }
}
