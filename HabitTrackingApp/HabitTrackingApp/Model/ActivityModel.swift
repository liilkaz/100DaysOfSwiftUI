//
//  ActivityModel.swift
//  HabitTrackingApp
//
//  Created by Лилия Феодотова on 19.08.2023.
//

import Foundation

struct ActivityModel: Codable, Identifiable, Equatable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var completionCount: Int
    //var date: Date
}
