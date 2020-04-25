//
//  RecipeInfoFetcher.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/25/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import Foundation

class RecipeInfoFetcher {
       static let manager = RecipeInfoFetcher()
        func fetchRecipeInfo(recipeId: String, completionHandler: @escaping(Result<RecipeInfo, NetWorkError>)-> ()){
               let urlString =  "https://api.spoonacular.com/recipes/\(recipeId)/information?includeNutrition=true&apiKey=\(Secrets.apiKey)"
            print(urlString)
            NetworkManager.manager.fetchData(urlString: urlString) { (result) in
                switch result{
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let data):
                    do{
                        let recipes = try JSONDecoder().decode(RecipeInfo.self, from: data)
                        completionHandler(.success(recipes))
                    } catch {
                        print(error)
                        completionHandler(.failure(.error))
                    }
                }
            }
        }
    }


