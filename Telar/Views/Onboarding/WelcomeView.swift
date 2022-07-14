//
//  WelcomeView.swift
//  Telar
//
//  Created by Romesh Singhabahu on 15/07/22.
//

import SwiftUI

struct WelcomeView: View {
    // MARK: - PROPERTIES
    @Binding var currentStep: OnboardingStep
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            
            Image("onboarding-welcome")
            
            Text("Bevenuti in DY Support")
                .font(Font.titleText)
                .padding(.top, 32)
            
            Text("Una chat semplice per i nostri clienti più fedeli")
                .font(Font.bodyParagraph)
                .padding(.top, 8)
            
            Spacer()
            
            Button {
                // Next Step
                currentStep = .phonenumber
            } label: {
                Text("Get Started")
            }
            .buttonStyle(OnboardingButtonStyle())
            
            Text("By tapping ‘Get Started’, you agree to our Privacy Policy.")
                .font(Font.smallText)
                .padding(.top, 14)
                .padding(.bottom, 61)

        } // VSTACK
        .padding(.horizontal)
    }
}
// MARK: - PREVIEWS
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(currentStep: .constant(.welcome))
    }
}
