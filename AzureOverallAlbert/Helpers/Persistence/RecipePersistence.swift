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
    private let persistenceHelper = PersistenceHelper<RecipeWrapper>(fileName: "recipes.plist")
    //Gets all recipes
    func getRecipes() throws -> [RecipeWrapper]{
        return try persistenceHelper.getObjects()
    }
    //Return one recipe with the unique id
    func getRecipe(id: Int) throws -> RecipeWrapper?{
        return try RecipePersistence.manager.getRecipes().filter{return $0.id == id}.first
    }
    func saveRecipe(info: RecipeWrapper) throws{
        try persistenceHelper.save(newElement: info)
    }
    //Takes in recipe id and finds the index to delete
    func deleteRecipe(id: Int) throws{
        var recipes = [RecipeWrapper]()
        recipes = try RecipePersistence.manager.getRecipes()
        
        var recipeIndex = Int()
        for (k,v) in recipes.enumerated(){
            if v.id == id{
                recipeIndex = k
            }
        }
        try persistenceHelper.delete(num: recipeIndex)
    }
    //Takes in recipe id and finds the index to edit
    func editRecipe(id: Int, newElement: RecipeWrapper) throws{
        var recipes = [RecipeWrapper]()
        recipes = try RecipePersistence.manager.getRecipes()
        var recipeIndex = Int()
        for (k,v) in recipes.enumerated(){
            if v.id == id{
                recipeIndex = k
            }
        }
        try persistenceHelper.edit(id: recipeIndex, newElement: newElement)
    }
    //Check if value id is in persisted list
    func checkIfSave(id: Int) -> Bool{
        var recipes = [RecipeWrapper]()
        do {
            recipes = try RecipePersistence.manager.getRecipes()
        }catch{
            print(error)
        }
        return recipes.contains{$0.id == id}
    }
}
