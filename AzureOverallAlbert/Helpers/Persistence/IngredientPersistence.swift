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
    func saveRecipe(info: Ingredients) throws{
      if checkIfSave(id: info.id){
         try deleteRecipe(id: info.id)
      }else {
        try persistenceHelper.save(newElement: info)
      }
   }
    //Takes in recipe id and finds the index to delete
    func deleteRecipe(id: Int) throws{
        var recipes = [Ingredients]()
        recipes = try IngredientPersistence.manager.getIngredients()
        
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
        var recipes = [Ingredients]()
        do {
            recipes = try IngredientPersistence.manager.getIngredients()
        }catch{
            print(error)
        }
        return recipes.contains{$0.id == id}
    }
}
