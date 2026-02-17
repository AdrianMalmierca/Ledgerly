//
//  AddExpenseView.swift
//  Ledgerly
//
//  Created by Adrián on 16/2/26.
//

import SwiftUI
import Lottie

struct AddExpenseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var amount = ""
    @State private var category = "Other"
    @State private var showAnimation = false
    
    let categories = ["Food", "Transport", "Bills", "Other"] // Categorías predefinidas
    let onSave: (String, Double, String) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Title", text: $title)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
                
                Section("Category") {
                    Picker("Select category", selection: $category) {
                        ForEach(categories, id: \.self) { cat in
                            Text(cat)
                        }
                    }
                    .pickerStyle(.menu) // O .segmented / .wheel según preferencia
                }
            }
            .navigationTitle("New Expense")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if let value = Double(amount) {
                            onSave(title, value, category)
                            showAnimation = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                dismiss()
                            }
                        }
                    }
                    .sheet(isPresented: $showAnimation) {
                        LottieView(name: "success")
                            .frame(width: 200, height: 200)
                    }
                    .disabled(title.isEmpty || amount.isEmpty) // Evitar guardar campos vacíos
                }
            }
        }
    }
}
