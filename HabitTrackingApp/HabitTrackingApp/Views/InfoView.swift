//
//  InfoView.swift
//  HabitTrackingApp
//
//  Created by Лилия Феодотова on 19.08.2023.
//

import SwiftUI

struct InfoView: View {
    @StateObject var activities = ActivityViewModel()
    var activity: ActivityModel
    
    var body: some View {
        VStack {
            Text(activity.title)
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.cyan.opacity(0.2).cornerRadius(10))
                    
            Text(activity.description).italic()
                .font(.system(size: 23))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.cyan.opacity(0.2).cornerRadius(10))

            Text("Completion count: \(activity.completionCount)")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.cyan.opacity(0.2))
                .cornerRadius(10)
            Button {
                activities.editActivities(activity: activity, data: activities)
            } label: {
                Text("Completed")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                   }
            Spacer()
            }
        .padding(.horizontal)
    }
}
           


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(activity: ActivityModel(title: "run", description: "run run run", completionCount: 0))
    }
}
