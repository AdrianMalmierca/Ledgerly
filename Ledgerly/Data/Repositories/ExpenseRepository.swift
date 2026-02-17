//
//  ExpenseRepository.swift
//  Ledgerly
//
//  Created by Adrián on 16/2/26.
//


import Foundation
import CoreData

final class ExpenseRepository: ExpenseRepositoryProtocol {
    
    private let context = CoreDataStack.shared.context
    private let network: NetworkServiceProtocol
    
    init(network: NetworkServiceProtocol = NetworkService()) {
        self.network = network
    }
    
    func fetchLocalExpenses() -> [Expense] {
        //petición de lectura
        let request: NSFetchRequest<ExpenseEntity> = ExpenseEntity.fetchRequest()
        
        do {
            let entities = try context.fetch(request)
            return entities.map { //mapeas de ExpenseEntity a Extense
                Expense(
                    id: $0.id ?? UUID(),
                    title: $0.title ?? "",
                    amount: $0.amount,
                    date: $0.date ?? Date(),
                    category: $0.category ?? "Other"
                )
            }
        } catch {
            return []
        }
    }
    
    func addExpense(_ expense: Expense) {
        //Creas una nueva entidad que se asocia al contexto, le asignas los valores del gasto y guardas el contexto
        let entity = ExpenseEntity(context: context)
        entity.id = expense.id
        entity.title = expense.title
        entity.amount = expense.amount
        entity.date = expense.date
        entity.category = expense.category
    }
    
    func deleteExpense(_ expense: Expense) {
        let request: NSFetchRequest<ExpenseEntity> = ExpenseEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", expense.id as CVarArg)

        if let entities = try? context.fetch(request), let entityToDelete = entities.first {
            context.delete(entityToDelete)
            try? context.save()
        }
    }
    
    func syncWithBackend() async throws {
        let remoteExpenses = try await network.fetchExpenses()
        
        for expense in remoteExpenses {
            // check if already exists
            let request: NSFetchRequest<ExpenseEntity> = ExpenseEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", expense.id as CVarArg)
            request.fetchLimit = 1
            
            let existing = try context.fetch(request)
            if existing.isEmpty {
                addExpense(expense) // solo se añade si no existe
            }
        }
        
        try context.save()
    }

}
