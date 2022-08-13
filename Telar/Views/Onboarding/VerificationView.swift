//
//  VerificationView.swift
//  Telar
//
//  Created by Romesh Singhabahu on 15/07/22.
//

import SwiftUI
import Combine

struct VerificationView: View {
    // MARK: - PROPERTIES
    @Binding var currentStep: OnboardingStep
    
    @State var verificationcode = ""
    
    // MARK: - BODY
    var body: some View {
        
        VStack {
            
            Text("Verification")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Inserisci il codice di verifica a 6 cifre che abbiamo inviato al tuo dispositivo.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            // Textfield
            ZStack {
                
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("", text: $verificationcode)
                        .font(Font.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(verificationcode)) { _ in
                            TextHelper.limitText(&verificationcode, 6)
                        }
                    
                    Spacer()
                    
                    Button {
                        // Clear text field
                        verificationcode = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .frame(width: 19, height: 19)
                    .tint(Color("icons-input"))
                    
                        
                        
                }
                .padding()
                
            }
            .padding(.top, 34)
            
            Spacer()
            
            Button {
                // Send the verification code to Firebase
                AuthViewModel.verifyCode(code: verificationcode) { error in
                    
                    // Check for errors
                    if error == nil {
                        
                        // Move to the next step
                        currentStep = .profile
                    }
                    else {
                        // TODO: Show error message
                    }
                }
                
            } label: {
                Text("Prossimo")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)

            
        } // VSTACk
        .padding(.horizontal)
    }
}

// MARK: - PREVIEWS
struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep: .constant(.verification))
    }
}
