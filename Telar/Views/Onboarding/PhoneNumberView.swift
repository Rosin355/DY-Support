//
//  PhoneNumberView.swift
//  Telar
//
//  Created by Romesh Singhabahu on 15/07/22.
//

import SwiftUI
import Combine

struct PhoneNumberView: View {
    // MARK: - PROPERTIES
    @Binding var currentStep: OnboardingStep
    
    @State var phoneNumber = ""
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text("Verifica")
                .font(Font.titleText)
                .padding(.top, 52)
                 
            Text("Inserisci il tuo numero di telefono. Ti mandaremo un codice di verifica a breve")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            /// TEXTFIELD
            ZStack {
                
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("ex: +39 (349) 8712345", text: $phoneNumber)
                        .font(Font.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(phoneNumber)) { _ in
                            TextHelper.applyPatternOnNumbers(&phoneNumber, pattern: "+## (###) #######", replacementCharacter: "#")
                        }
                    
                    Spacer()
                    
                    Button {
                        // Clear text field
                        phoneNumber = ""
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
                
                //  Send number to Firebase Auth
                AuthViewModel.sendPhoneNumber(phone: phoneNumber) { error in
                    // check for the errors
                    if error == nil {
                        // Move to the next step
                        currentStep = .verification
                    } else {
                        // TODO: show the error
                    }
                }
               
            } label: {
                Text("Successivo")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            
        } // VSTACK
        .padding(.horizontal)
    }
}

// MARK: - PREVIEWS
struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(currentStep: .constant(.phonenumber))
    }
}
