//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Лилия Феодотова on 17.09.2023.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
