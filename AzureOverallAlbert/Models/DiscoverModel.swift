//
//  DiscoverModel.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 5/6/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import Foundation
struct DiscoverModel {
   let titles: [String]
   let cuisines: [String]
   let diets: [String]
   let suggests: [String]
   let discoverTypes: [[String]]
   init (){
      self.cuisines = ["African","America","British","Cajun", "Caribbean","Chinese",  "Eastern","European","European","French","German",  "Greek","Indian","Irish","Italian","Japanese","Jewish","Korean","Latin American","Mediterranean","Mexican","Middle Eastern","Nordic","Southern","Spanish","Thai","Vietnamese"]
      self.diets = ["Gluten Free","Ketogenic","Vegetarian", "Lacto-Vegetarian", "Ovo-Vegetarian", "Vegan", "Pescetarian", "Paleo", "Primal", "Whole30"]
      self.suggests = ["stuff"]
      self.discoverTypes = [cuisines, diets, suggests ]
      self.titles = ["Cuisines", "Diets", "Suggestions"]
   }
}
