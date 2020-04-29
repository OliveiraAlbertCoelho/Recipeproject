//
//  RecipePersistence.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/31/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import Foundation


struct RecipePersistence{
    static let manager = RecipePersistence()
    private let persistenceHelper = PersistenceHelper<RecipeInfo>(fileName: "recipes.plist")
    //Gets all recipes
    func getRecipes() throws -> [RecipeInfo]{
        return try persistenceHelper.getObjects()
    }
    func saveRecipe(info: RecipeInfo) throws{
      if checkIfSave(id: info.id){
         try deleteRecipe(id: info.id)
      }else {
        try persistenceHelper.save(newElement: info)
      }
   }
    //Takes in recipe id and finds the index to delete
    func deleteRecipe(id: Int) throws{
        var recipes = [RecipeInfo]()
        recipes = try RecipePersistence.manager.getRecipes()
        
        var recipeIndex = Int()
        for (k,v) in recipes.enumerated(){
            if v.id == id{
                recipeIndex = k
            }
        }
        try persistenceHelper.delete(num: recipeIndex)
    }

    //Check if value id is in persisted list
    func checkIfSave(id: Int) -> Bool{
        var recipes = [RecipeInfo]()
        do {
            recipes = try RecipePersistence.manager.getRecipes()
        }catch{
            print(error)
        }
        return recipes.contains{$0.id == id}
    }
}
//func editRecipe(id: Int, newElement: RecipeInfo) throws{
//       var recipes = [RecipeInfo]()
//       recipes = try RecipePersistence.manager.getRecipes()
//       var recipeIndex = Int()
//       for (k,v) in recipes.enumerated(){
//           if v.id == id{
//               recipeIndex = k
//           }
//       }
//       try persistenceHelper.edit(id: recipeIndex, newElement: newElement)
//   }
//Return one recipe with the unique id
//   func getRecipe(id: Int) throws -> RecipeInfo?{
//       return try RecipePersistence.manager.getRecipes().filter{return $0.id == id}.first
//   }
