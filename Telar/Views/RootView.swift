//
//  RootView.swift
//  Telar
//
//  Created by Romesh Singhabahu on 13/07/22.
//

import SwiftUI

struct RootView: View {
    // MARK: - PROPERTIES
    @State var selectedTab: Tabs = .contacts
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    @State var isChatShowing = false
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                switch selectedTab {
                    case .chats:
                        ChatsListView()
                    case .contacts:
                        ContactsListView(isChatShowing: $isChatShowing)
                }
                
                Spacer()
                
                CustomTabBar(selectedTab: $selectedTab)
            }
            .fullScreenCover(isPresented: $isOnboarding) {
                // On dismmis
            } content: {
                // The onboarding sequence
                OnboardingContainerView(isOnboarding: $isOnboarding)
            }
            .fullScreenCover(isPresented: $isChatShowing, onDismiss: nil) {
                // conversation view
                ConversationView(isChatSwowing: $isChatShowing)
            }
        }
    }
    
    // MARK: - PREVIEWS
    struct RootView_Previews: PreviewProvider {
        static var previews: some View {
            RootView()
        }
    }
}
