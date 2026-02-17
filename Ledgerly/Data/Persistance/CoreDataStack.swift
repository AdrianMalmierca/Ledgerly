//
//  CoreDataStack.swift
//  Ledgerly
//
//  Created by Adrián on 16/2/26.
//

import CoreData

final class CoreDataStack {
    
    //Se crea instancia de CoreDataStack para usar en toda la app. Patron singleton
    static let shared = CoreDataStack()
    
    //carga el modelo y crea db
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "LedgerlyModel")//se carga el archivo
        
        //carga la db, si falla se muestra error
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData failed: \(error)")
            }
        }
    }
    
    //se expone el contexto
    var context: NSManagedObjectContext {
        container.viewContext
    }
}
