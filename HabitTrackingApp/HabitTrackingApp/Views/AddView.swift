//
//  AddView.swift
//  HabitTrackingApp
//
//  Created by Лилия Феодотова on 19.08.2023.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var activities: ActivityViewModel
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var description = ""

    var body: some View {
        NavigationView {
            VStack{
                TextField("Name", text: $title)
                    .padding()
                    .background(Color.cyan.opacity(0.2).cornerRadius(10))
                    
                TextField("Description", text: $description)
                    .padding()
                    .background(Color.cyan.opacity(0.2).cornerRadius(10))
                
                Button {
                    activities.addActivities(title: title, description: description)
                    dismiss()
                } label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(title.isEmpty ? Color.gray.cornerRadius(10) : Color.blue.cornerRadius(10))
                }
                Spacer()
            }

            .navigationTitle("Add new activity")
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
            }
        } .padding(.horizontal)
    }
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: ActivityViewModel())
    }
}
