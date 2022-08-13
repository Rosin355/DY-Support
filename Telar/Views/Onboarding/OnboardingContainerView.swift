//
//  OnboardingContainerView.swift
//  Telar
//
//  Created by Romesh Singhabahu on 14/07/22.
//

import SwiftUI

enum OnboardingStep: Int {
    
    case welcome = 0
    case phonenumber = 1
    case verification = 2
    case profile = 3
    case contacts = 4
}

struct OnboardingContainerView: View {
    
    // MARK: - PROPERTIES
    @Binding var isOnboarding: Bool
    @State var currentStep: OnboardingStep = .welcome
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea(edges: [.top, .bottom])
            
            switch currentStep  {
                case .welcome:
                    WelcomeView(currentStep: $currentStep)
                
                case .phonenumber:
                    PhoneNumberView(currentStep: $currentStep)
                
                case .verification:
                    VerificationView(currentStep: $currentStep)
                    
                case .profile:
                    CreateProfileView(currentStep: $currentStep)
                    
                case .contacts:
                    SyncContactsView(isOnboarding: $isOnboarding)
            }
        }
    }
}
// MARK: - PREVIEWS
struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContainerView(isOnboarding: .constant(true))
    }
}
