//
//  ActivityViewModel.swift
//  HabitTrackingApp
//
//  Created by Лилия Феодотова on 19.08.2023.
//

import Foundation

class ActivityViewModel: ObservableObject {
    @Published var activities = [ActivityModel]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedItems = try? JSONDecoder().decode([ActivityModel].self, from: savedItems) {
                activities = decodedItems
                return
            }
        }
        activities = []
    }
    
    func addActivities(title: String, description: String) {
        let addNewActivity = ActivityModel(title: title, description: description, completionCount: 0)
        activities.append(addNewActivity)
    }
    
    func editActivities(activity: ActivityModel, data: ActivityViewModel) {
        var editActivity = activity
        editActivity.completionCount += 1
                
        if let index = data.activities.firstIndex(of: activity) {
            data.activities[index] = editActivity
        }
    }
    
    func removeActivity(index: IndexSet) {
        activities.remove(atOffsets: index)
    }
}
