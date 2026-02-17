//
//  ExpenseListViewModel.swift
//  Ledgerly
//
//  Created by Adrián on 16/2/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class ExpenseListViewModel: ObservableObject {
    
    // MARK: - Inputs
    @Published var searchText: String = ""               // Nuevo: campo de búsqueda
    @Published var selectedCategory: String? = nil
    
    // MARK: - Outputs
    @Published private(set) var expenses: [Expense] = []
    @Published private(set) var filteredExpenses: [Expense] = [] // Ahora reactivo
    
    private let repository: ExpenseRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()   // Para Combine
    
    init(repository: ExpenseRepositoryProtocol = ExpenseRepository()) {
        self.repository = repository
        
        loadExpenses()
        setupBindings()
    }
    
    // MARK: - Carga de gastos
    func loadExpenses() {
        expenses = repository.fetchLocalExpenses()
        filteredExpenses = expenses
    }
    
    func addExpense(title: String, amount: Double, category: String) {
        let expense = Expense(
            id: UUID(),
            title: title,
            amount: amount,
            date: Date(),
            category: category
        )
        repository.addExpense(expense)
        loadExpenses()
    }
    
    func deleteExpense(_ expense: Expense) {
        repository.deleteExpense(expense)
        loadExpenses()
    }
    
    func sync() async {
        try? await repository.syncWithBackend()
        loadExpenses()
    }
    
    // MARK: - Combine bindings
    private func setupBindings() {
        // Filtrado reactivo: categoría + búsqueda
        Publishers.CombineLatest($searchText, $selectedCategory)
            .map { [weak self] (query, category) -> [Expense] in
                guard let self = self else { return [] }
                return self.expenses.filter { expense in
                    let matchesCategory = category == nil || expense.category == category
                    let matchesSearch = query.isEmpty || expense.title.lowercased().contains(query.lowercased())
                    return matchesCategory && matchesSearch
                }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.filteredExpenses, on: self)
            .store(in: &cancellables)
    }
}
