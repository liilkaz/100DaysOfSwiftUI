//
//  ContentView.swift
//  FriendFace
//
//  Created by Лилия Феодотова on 17.09.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var vm = UserViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.users) { user in
                    NavigationLink {
                        UserView(user: user)
                    } label: {
                        HStack(spacing: 12) {
                            Circle()
                                .fill(user.isActive ? .green : .red.opacity(0.5))
                                .frame(width: 14, height: 14)
                            
                            VStack(alignment: .leading, spacing: 3) {
                                Text(user.name)
                                
                                Text(user.email)
                                    .foregroundColor(.gray.opacity(0.7))
                            }
                        }
                        .padding(5)
                    }
                }
            }
            .navigationTitle("Users List")
        }
        .task {
            vm.fetcUsersList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
