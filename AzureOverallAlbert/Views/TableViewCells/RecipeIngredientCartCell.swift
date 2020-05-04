//
//  RecipeIngredientCartCell.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 5/4/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

   //MARK: - Lifecycle
class RecipeIngredientCartCell: UITableViewCell {
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setUpView()
   }
   required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   //MARK: - UI Objects
   lazy var stepNumber: UILabel = {
      let label = UILabel()
      label.font = .boldSystemFont(ofSize: 18)
      label.textColor = .orange
      label.textAlignment = .center
      return label
   }()
   lazy var stepTitle: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.textAlignment = .justified
      label.font = .systemFont(ofSize: 18)
      return label
   }()
 
   
}
