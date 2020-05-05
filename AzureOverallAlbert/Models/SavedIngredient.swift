//
//  IngredientPersistence.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 5/5/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import Foundation

struct SavedIngredient: Codable{
   let name: String
   var persistedImage: Data?
   let id: Int
   var ingredients: [Ingredients]?
   init(_ recipeInfo: RecipeInfo) {
      self.name = recipeInfo.title
      self.id = recipeInfo.id
   }
}
