//
//  SyncContactView.swift
//  Telar
//
//  Created by Romesh Singhabahu on 15/07/22.
//

import SwiftUI

struct SyncContactsView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var isOnboarding: Bool
    
    // MARK: - BODY
    var body: some View {
        
        VStack {
            Spacer()
            
            Image("onboarding-all-set")
            
            Text("Ottimo!")
                .font(Font.titleText)
                .padding(.top, 32)
            
            Text("Continue to start chatting with your friends.")
                .font(Font.bodyParagraph)
                .padding(.top, 8)
            
            
            Spacer()
            
            Button {
                // End onboarding
                isOnboarding = false
                
            } label: {
                
                Text("Continua")
                
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)

            
        }
        .padding(.horizontal)
        .onAppear {
            // Get local contacts
            contactsViewModel.getLocalContacts()
        }
    }
}

// MARK: - PREVIEWS
struct SyncContactView_Previews: PreviewProvider {
    static var previews: some View {
        SyncContactsView(isOnboarding: .constant(true))
    }
}
