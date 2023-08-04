//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Лилия Феодотова on 04.08.2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
