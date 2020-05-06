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
   func fetchRecipes(searchInfo: String, completionHandler: @escaping(Result<[RecipeWrapper], NetWorkError>)-> ()){
      let randomRecipes = ["pizza", "burger", "cake", "pasta", "cake", "juice"]
      var search = searchInfo.replacingOccurrences(of: " ", with: "-")
      if searchInfo.isEmpty {
         search = randomRecipes.randomElement() ?? "pizza"
      }
      let urlString = "https://api.spoonacular.com/recipes/search?&query=\(search)&limitLicense=false&number=10&apiKey=\(Secrets.apiKey)"
      print(urlString)
      NetworkManager.manager.fetchData(urlString: urlString) { (result) in
         switch result{
         case .failure(let error):
            print(urlString)
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
