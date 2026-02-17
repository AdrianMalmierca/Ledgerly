//
//  Expense.swift
//  Ledgerly
//
//  Created by Adrián on 16/2/26.
//

import Foundation

struct Expense: Identifiable, Codable {
    let id: UUID
    var title: String
    var amount: Double
    var date: Date
    var category: String
}
