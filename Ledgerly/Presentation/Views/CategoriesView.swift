//
//  CategoriesView.swift
//  Ledgerly
//
//  Created by Adrián on 16/2/26.
//

import SwiftUI

struct CategoriesGridView: View {
    let categories: [String]
    @Binding var selectedCategory: String?

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                    ForEach(categories, id: \.self) { category in
                        Button {
                            if selectedCategory == category {
                                selectedCategory = nil
                            } else {
                                selectedCategory = category
                            }
                        } label: {
                            Text(category)
                                .padding(10)
                                .background(selectedCategory == category ? Color.blue.opacity(0.7) : Color.gray.opacity(0.2))
                                .foregroundColor(selectedCategory == category ? .white : .black)
                                .cornerRadius(10)
                        }
                    }
                }
                .frame(width: width, alignment: .center)
            }
        }
        .frame(height: 60)
    }
}


