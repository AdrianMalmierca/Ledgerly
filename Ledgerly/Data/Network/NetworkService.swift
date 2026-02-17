//
//  NetworkService.swift
//  Ledgerly
//
//  Created by Adrián on 16/2/26.
//

import Foundation

//any class that implements this protocol must provide these two methods, one for fetching expenses and another for sending an expense to the backend
protocol NetworkServiceProtocol {
    func fetchExpenses() async throws -> [Expense]
    func sendExpense(_ expense: Expense) async throws
}

final class NetworkService: NetworkServiceProtocol {
    
    //is not a real backend, but a public API that returns a list of posts in JSON format
    private let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
    
    func fetchExpenses() async throws -> [Expense] {
        let url = baseURL.appendingPathComponent("posts")
        
        //we need the information so we ignore the response
        let (data, _) = try await URLSession.shared.data(from: url) //petición get
        
        //trasnforma de JSON a objeto swift
        let decoded = try JSONDecoder().decode([PostDTO].self, from: data)
        
        //solo se cogen los primeros 20 posts para crear gastos, ya que el endpoint devuelve 100 posts
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
