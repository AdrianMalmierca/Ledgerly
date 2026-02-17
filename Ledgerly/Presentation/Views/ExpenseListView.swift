//
//  ExpenseListViewModel.swift
//  Ledgerly
//
//  Created by Adrián on 16/2/26.
//

import SwiftUI

struct ExpenseListView: View {
    
    @StateObject private var viewModel = ExpenseListViewModel()
    @State private var showingAdd = false
    
    // Lista de categorías disponibles
    private let categories = ["Food", "Social", "Bills", "Other"]
    
    var body: some View {
        NavigationStack {
            VStack {
                
                CategoriesGridView(categories: categories,
                                   selectedCategory: $viewModel.selectedCategory)
                    .padding(.vertical, 5)
                
                List {
                    ForEach(viewModel.filteredExpenses) { expense in
                        NavigationLink {
                            ExpenseDetailView(expense: expense)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(expense.title)
                                    .font(.headline)
                                Text("\(expense.amount, specifier: "%.2f") €")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let expense = viewModel.filteredExpenses[index]
                            viewModel.deleteExpense(expense)
                        }
                    }
                }
            }
            .navigationTitle("Ledgerly")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Sync") {
                        Task {
                            await viewModel.sync()
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddExpenseView { title, amount, category in
                    viewModel.addExpense(title: title, amount: amount, category: category)
                }
            }
        }
    }
}
