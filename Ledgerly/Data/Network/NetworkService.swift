//
//  NetworkService.swift
//  Ledgerly
//
//  Created by Adrián on 16/2/26.
//

import Foundation

//Cualquier clase que implemente el protocolo debe tener estas dos funciones. Para inyección de dependencias y desacoplamiento
protocol NetworkServiceProtocol {
    func fetchExpenses() async throws -> [Expense]
    func sendExpense(_ expense: Expense) async throws
}

final class NetworkService: NetworkServiceProtocol {
    
    //no es backend real
    private let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
    
    func fetchExpenses() async throws -> [Expense] {
        let url = baseURL.appendingPathComponent("posts")
        
        //Simplemente necesito la información, no la respuesta de la url
        let (data, _) = try await URLSession.shared.data(from: url) //petición get
        
        //trasnforma de JSON a objeto swift
        let decoded = try JSONDecoder().decode([PostDTO].self, from: data)
        
        //solo se cogen los primeros 5 posts para crear gastos, ya que el endpoint devuelve 100 posts
        return decoded.prefix(20).map {
            //se crea un gasto a partir del título de cada post, con cantidad aleatoria y fecha actual
            Expense(
                id: UUID(),
                title: $0.title,
                amount: Double.random(in: 5...100),
                date: Date(),
                category: "Other"
            )
        }
    }
    
    func sendExpense(_ expense: Expense) async throws {
        let url = baseURL.appendingPathComponent("posts")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = try JSONEncoder().encode(expense)
        
        //no interesa la respuesta, simplemente que lance error si falla
        _ = try await URLSession.shared.data(for: request)
    }
}

private struct PostDTO: Decodable {
    //solo coge el title de la petición
    let title: String
}
