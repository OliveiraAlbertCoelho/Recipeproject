//
//  RecipesModel.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import Foundation

struct Recipes: Codable{
    let results: [RecipeWrapper]
}
struct RecipeWrapper: Codable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let image: String
    var recipeUrl: String {
        return "https://spoonacular.com/recipeImages/\(id)-636x393.jpg"
   }
    var itemsInCart: Int?
    var persistedImage: Data?
}
