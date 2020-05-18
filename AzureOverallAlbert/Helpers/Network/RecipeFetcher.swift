//
//  RecipeFetcher.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import Foundation

class RecipeFetcher {
   static let manager = RecipeFetcher()
   func fetchRecipes(searchInfo: String, fetchRecipeType: FetchRecipeType, completionHandler: @escaping(Result<[RecipeWrapper], NetWorkError>)-> ()){
      var searchCategory = String()
      switch fetchRecipeType {
      case .cuisine:
         searchCategory = "cuisine"
      case .diet:
         searchCategory = "diet"
      default:
         searchCategory = "query"
      }
    let urlString = "https://api.spoonacular.com/recipes/search?&\(searchCategory)=\(searchInfo)&limitLicense=false&number=10&apiKey=\(Secrets.apiKey)"
      print(urlString)
            print(urlString)
      NetworkManager.manager.fetchData(urlString: urlString) { (result) in
         switch result{
         case .failure(let error):
            completionHandler(.failure(error))
         case .success(let data):
            do{
               let recipes = try JSONDecoder().decode(Recipes.self, from: data)
               completionHandler(.success(recipes.results))
            } catch {
               completionHandler(.failure(.error))
            }
         }
      }
   }
}

enum FetchRecipeType {
   case diet
   case cuisine
   case query
}
