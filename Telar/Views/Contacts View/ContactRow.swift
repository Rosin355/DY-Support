//
//  ContactRow.swift
//  Telar
//
//  Created by Romesh Singhabahu on 18/08/22.
//

import SwiftUI

struct ContactRow: View {
    // MARK: - PROPERTIES
    var user: User
    
    // MARK: - BODY
    var body: some View {
        
        HStack (spacing: 24) {
            
           ProfilePicView(user: user)
            
            VStack (alignment: .leading, spacing: 4) {
                // Name
                Text("\(user.firstname ?? "") \(user.lastname ?? "")")
                    .font(Font.button)
                    .foregroundColor(Color("text-primary"))
                
                // Phone number
                Text(user.phone ?? "")
                    .font(Font.bodyParagraph)
                    .foregroundColor(Color("text-input"))
            }
            
            // Extra space
            Spacer()
        } //VSTACK
    }
}

// MARK: - PREVIEWS
struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(user: User())
    }
}
