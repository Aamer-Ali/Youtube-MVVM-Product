//
//  Product.swift
//  Youtube MVVM Product
//
//  Created by aamer sayyed on 05/05/24.
//

import Foundation

// MARK: - Employee
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
    let rating: Rating
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

