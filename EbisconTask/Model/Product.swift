//
//  Product.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 08.02.23.
//

import Foundation




struct Product: Codable, Hashable {

    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
