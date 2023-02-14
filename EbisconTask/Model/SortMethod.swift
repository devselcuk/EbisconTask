//
//  Filter.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 09.02.23.
//

import Foundation



enum SortMethod : String, Hashable, CaseIterable {
    case topRated = "Top Rated"
    case nearest = "Nearest Me"
    case highToLow = "Cost High To Low"
    case lowToHigh = "Cost Low To High"
}
