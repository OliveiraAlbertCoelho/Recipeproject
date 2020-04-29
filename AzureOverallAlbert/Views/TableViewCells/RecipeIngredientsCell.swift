//
//  RecipeIngredientsCell.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/26/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class RecipeIngredientsCell: UITableViewCell {
   
   //MARK: - Lifecycle
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setUpView()
   }
   
   required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   //MARK: - UI Objects
   lazy var addIngredientButton: UIButton = {
      let button = UIButton()
      button.setImage(UIImage(systemName: "heart"), for: .normal)
      button.tintColor = .black
      return button
   }()
   
   lazy var ingredientTitleLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      return label
   }()
   //MARK: - Regular Functions
   private func setUpView(){
      contentView.backgroundColor = #colorLiteral(red: 0.9489366412, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
      constrainIngredientButton()
      constrainIngredientTitleLabel()
   }
   //MARK: - Constraints
   private func constrainIngredientButton(){
      contentView.addSubview(addIngredientButton)
      addIngredientButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         addIngredientButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
         addIngredientButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
         addIngredientButton.heightAnchor.constraint(equalToConstant: 50),
         addIngredientButton.widthAnchor.constraint(equalToConstant: contentView.frame.width/6)
      ])
   }
   
   private func constrainIngredientTitleLabel(){
      contentView.addSubview(ingredientTitleLabel)
      ingredientTitleLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         ingredientTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
         ingredientTitleLabel.leadingAnchor.constraint(equalTo: addIngredientButton.trailingAnchor, constant: 0),
         ingredientTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
         ingredientTitleLabel.heightAnchor.constraint(equalToConstant: 40),
      ])
   }
   
   
}
