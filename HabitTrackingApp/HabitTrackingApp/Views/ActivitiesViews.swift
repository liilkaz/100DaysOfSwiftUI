//
//  ActivitiesViews.swift
//  HabitTrackingApp
//
//  Created by Лилия Феодотова on 19.08.2023.
//

import SwiftUI

struct ActivitiesViews: View {
    @StateObject var activities = ActivityViewModel()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.activities) { activity in
                    NavigationLink {
                        InfoView(activities: activities, activity: activity)
                    } label: {
                        HStack {
                            Text("\(activity.title) - ").bold()
                            Text("(\(activity.description))").italic()
                            Spacer()
                            Text("\(activity.completionCount)")
                                .foregroundColor(.white)
                                .background(Circle()
                                    .fill(Color.cyan)
                                    .frame(width: 40, height: 28))
                                .padding(.horizontal)
                        }
                    }
                }
                .onDelete(perform: activities.removeActivity)
            }
            .navigationTitle("Habit Tracker")
                .toolbar {
                    Button {
                        showingAddActivity.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                } .sheet(isPresented: $showingAddActivity) {
                    AddView(activities: activities)
                }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesViews()
    }
}
