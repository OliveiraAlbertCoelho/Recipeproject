//
//  RecipeInfo.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/25/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import Foundation

struct RecipeInfo: Codable {

    let nutrition: NutrientsWrapper
}
struct NutrientsWrapper: Codable {
    let nutrients: [Nutrients]
}
struct Nutrients: Codable {
    let title: String
    let amount: Double
    let unit: String
}
