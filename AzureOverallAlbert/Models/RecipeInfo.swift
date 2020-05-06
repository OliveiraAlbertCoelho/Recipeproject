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
   var persistedImage: Data?
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
   var fromRecipe: String?
   var recipeID: String?
   var ingredientImageUrl: String {
      return "https://spoonacular.com/cdn/ingredients_500x500/\(image)"}
   var ingredientAmount: String {
      if unit.isEmpty {
         return "\(amount.getMeasureFromDouble(value: amount)) \(name.capitalized)"
      }
      return "\(amount.getMeasureFromDouble(value: amount)) \(unitFormat) of \(name.capitalized)"
   }
   var unitFormat: String {
      switch unit {
      case "teaspoons", "teaspoon" :
         return "tspn"
      case "tablespoon", "tablespoons" :
         return "tbsp"
      default:
         return unit
      }
   }
 static  func recipeNameForHeader(_ ingredients: [Ingredients])-> [String]{
      var result = [String]()
      for i in ingredients{
         if let recipeName = i.fromRecipe{
            if !result.contains(recipeName){
               result.append(recipeName)}
         }
      }
      return result
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
extension Double {
   func getMeasureFromDouble( value: Double) -> String {
      var doubleRemainder = value
      var roundedDownStr = Int(doubleRemainder.rounded(.down)).description
      doubleRemainder.formTruncatingRemainder(dividingBy: 1.0)
      var measure = String()
      switch doubleRemainder {
      case 0.75:
         measure = "3/4"
      case 0.5:
         measure = "1/2"
      case 0.3333333333333333:
         measure = "1/3"
      case 0.6666666666666666:
         measure = "2/3"
      case 0.16:
         measure = "1/6"
      case 0.12, 0.13:
         measure = "1/8"
      case 0.25:
         measure = "1/4"
      default:
         measure = ""
      }
      if roundedDownStr == "0"{
        return measure
      }
      return "\(roundedDownStr) \(measure)"
   }
}
