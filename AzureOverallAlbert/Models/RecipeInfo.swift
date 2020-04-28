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
   let id: Int
   let title: String
   let readyInMinutes: Int
   let servings: Int
   let image: String
   var recipeUrl: String {
       return "https://spoonacular.com/recipeImages/\(id)-556x370.jpg"
   }
   let extendedIngredients: [Ingredients]
   let analyzedInstructions: [AnalyzedInstructions]
}
struct AnalyzedInstructions: Codable{
   let name: String
   let steps: [Instructions]
}
struct Instructions: Codable{
   let number: Int
   let step: String
}
struct Ingredients: Codable{
   let id: Int
   let image: String
   let name: String
   let amount: Double
   let unit: String
   var ingredientAmount: String {
      return "\(name.capitalized) \(amount) \(unit.capitalized)"
   }
}
struct NutrientsWrapper: Codable {
    let nutrients: [Nutrients]
}
struct Nutrients: Codable {
    let title: String
    let amount: Double
    let unit: String
}
