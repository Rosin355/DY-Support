//
//  TelarApp.swift
//  Telar
//
//  Created by Romesh Singhabahu on 13/07/22.
//

import SwiftUI


@main
struct TelarApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(ContactsViewModel())
                .environmentObject(ChatViewModel())
        }
    }
}
