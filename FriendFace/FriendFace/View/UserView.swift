//
//  UserView.swift
//  FriendFace
//
//  Created by Лилия Феодотова on 17.09.2023.
//

import SwiftUI

struct UserView: View {
    var user: User
    
    var body: some View {
        List {
            Section("User Info") {
                HStack {
                    Text("Name:").bold()
                    Text(user.name)
                }
                HStack {
                    Text("Age:").bold()
                    Text(String(user.age))
                }
                HStack {
                    Text("Email:").bold()
                    Text(user.email)
                }
                HStack {
                    Text("Company:").bold()
                    Text(user.company)
                }
                HStack {
                    Text("Address:").bold()
                    Text(user.address)
                }
                HStack {
                    Text("Registered:").bold()
                    Text(user.registered.formatted(date: .numeric, time: .omitted))
                }
            }
            
            Section("About") {
                Text(user.about)
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .navigationTitle(user.name)
    }
}
