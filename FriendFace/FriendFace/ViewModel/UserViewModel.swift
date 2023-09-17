//
//  UserViewModel.swift
//  FriendFace
//
//  Created by Лилия Феодотова on 17.09.2023.
//

import Foundation
import SwiftUI

final class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    
    @MainActor public func fetcUsersList() {
        APICaller.shared.getUsersList() { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.users = user
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}
