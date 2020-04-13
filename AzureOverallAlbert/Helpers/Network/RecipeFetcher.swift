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
        let urlString = "https://api.spoonacular.com/recipes/search?&query=\(searchInfo)&number=50&apiKey=\(Secrets.apiKey)"
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
