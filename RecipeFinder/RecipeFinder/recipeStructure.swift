//
//  parkStruct.swift
//  NationalParks
//
//  Created by Jimmy Ren on 11/14/20.
//

import Foundation

struct APIResponse: Codable{
    let hits: [Hit]
}
struct Hit: Codable{
    let recipe: Recipe
    let bookmarked: Bool
}

struct Recipe: Codable {
    let label: String
    let image: String
    let source: String
    let url: String
    let calories: Double
}


