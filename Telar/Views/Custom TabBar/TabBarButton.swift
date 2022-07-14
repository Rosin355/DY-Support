//
//  TabBarButton.swift
//  Telar
//
//  Created by Romesh Singhabahu on 14/07/22.
//

import SwiftUI

struct TabBarButton: View {
    // MARK: - PROPERTIES
    var buttonText: String
    var imageName: String
    var isActive: Bool

    //MARK: - BODY
    var body: some View {
        GeometryReader { geo in
            
            if isActive {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geo.size.width/2, height: 4)
                    .padding(.leading, geo.size.width/4)
            }
            
            VStack (alignment: .center, spacing: 4) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text(buttonText)
                    .font(Font.tabBar)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

//MARK: - PREVIEWS
struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(buttonText: "Chats", imageName: "bubble.left", isActive: true)
    }
}
