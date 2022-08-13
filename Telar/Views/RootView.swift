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
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text("DY-CHAT!")
                .padding()
                .font(Font.chatHeading)
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .fullScreenCover(isPresented: $isOnboarding) {
            // On dismmis
        } content: {
            // The onboarding sequence
            OnboardingContainerView(isOnboarding: $isOnboarding)
        }
    }
}

// MARK: - PREVIEWS
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
