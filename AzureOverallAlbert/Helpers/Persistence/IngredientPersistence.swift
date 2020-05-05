//
//  IngredientPersistence.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import Foundation





struct IngredientPersistence{
   static let manager = IngredientPersistence()
   private let persistenceHelper = PersistenceHelper<Ingredients>(fileName: "ingredients.plist")
   //Gets all recipes
   func getIngredients() throws -> [Ingredients]{
      return try persistenceHelper.getObjects()
   }
   func saveIngredient(info: Ingredients) throws{
      if checkIfSave(id: info.id){
         try deleteIngredient(id: info.id)
      }else {
         try persistenceHelper.save(newElement: info)
      }
   }
   //Takes in recipe id and finds the index to delete
   func deleteIngredient(id: Int) throws{
      var ingredients = [Ingredients]()
      ingredients = try IngredientPersistence.manager.getIngredients()
      var ingredientIndex = Int()
      for (k,v) in ingredients.enumerated(){
         if v.id == id{
            ingredientIndex = k
         }
      }
      try persistenceHelper.delete(num: ingredientIndex)
   }
   //Check if value id is in persisted list
   func checkIfSave(id: Int) -> Bool{
      var ingredients = [Ingredients]()
      do {
         ingredients = try IngredientPersistence.manager.getIngredients()
      }catch{
         print(error)
      }
      return ingredients.contains{$0.id == id}
   }
}
