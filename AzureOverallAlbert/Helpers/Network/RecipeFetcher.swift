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
   func fetchRecipes(searchInfo: String, searchType: SearchType, completionHandler: @escaping(Result<[RecipeWrapper], NetWorkError>)-> ()){
    var search = searchInfo.replacingOccurrences(of: " ", with: "-")
      var urlString = "https://api.spoonacular.com/recipes/search?&query=\(search)&limitLicense=false&number=10&apiKey=\(Secrets.apiKey)"
      switch searchType {
      case .suggestion:
         let randomRecipes = ["pizza", "burger", "cake", "pasta", "cake", "juice"]
         if searchInfo.isEmpty {
            search = randomRecipes.randomElement() ?? "pizza"
         }
      case .diet:
        urlString = "https://api.spoonacular.com/recipes/search?&diet=\(search)&limitLicense=false&number=10&apiKey=\(Secrets.apiKey)"
         
      default:
         urlString =    "https://api.spoonacular.com/recipes/search?&cuisine=\(search)&limitLicense=false&number=10&apiKey=\(Secrets.apiKey)"
      }
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
enum SearchType {
   case diet
   case cuisine
   case suggestion
}
