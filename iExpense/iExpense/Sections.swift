//
//  Sections.swift
//  iExpense
//
//  Created by Лилия Феодотова on 04.08.2023.
//

import Foundation

import SwiftUI

struct Sections: View {
    
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(item.amount >= 100 ? .orange : item.amount < 10 ? .green : .blue  )
                    
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
}
