//
//  SyncContactView.swift
//  Telar
//
//  Created by Romesh Singhabahu on 15/07/22.
//

import SwiftUI

struct SyncContactView: View {
    // MARK: - PROPERTIES
    @Binding var isOnboarding: Bool
    
    // MARK: - BODY
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - PREVIEWS
struct SyncContactView_Previews: PreviewProvider {
    static var previews: some View {
        SyncContactView(isOnboarding: .constant(true))
    }
}
