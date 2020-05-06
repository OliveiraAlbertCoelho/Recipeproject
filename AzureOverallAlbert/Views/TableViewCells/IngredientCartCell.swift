//
//  RecipeIngredientCartCell.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 5/4/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

   //MARK: - Lifecycle
class IngredientCartCell: UITableViewCell {
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setUpView()
   }
   required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   //MARK: - UI Objects
   lazy var ingredientPicture: UIImageView = {
      let image = UIImageView()
      return image
   }()
   lazy var ingredientTitleLabel: UILabel = {
   let label = UILabel()
      label.numberOfLines = 0
   return label
   }()
   lazy var checkButton: UIButton = {
      let button = UIButton()
      button.setImage(UIImage(systemName: "cart.badge.minus"), for: .normal)
      button.tintColor = .orange
      button.addTarget(self, action: #selector(checkButtonAction), for: .touchUpInside)
      return button
   }()
   weak var delegate: ButtonProtocol?
   //MARK: - Regular functions
  @objc private func checkButtonAction(){
   delegate?.pressAction(row: checkButton.tag, section: nil, type: .cell)
   }
   private func setUpView(){
      constrainIngredientPicture()
      constrainCheckButton()
      constrainIngredientTitleLabel()
   }
   
   private func constrainIngredientPicture(){
      contentView.addSubview(ingredientPicture)
      ingredientPicture.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         ingredientPicture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         ingredientPicture.topAnchor.constraint(equalTo: contentView.topAnchor),
         ingredientPicture.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),         ingredientPicture.widthAnchor.constraint(equalToConstant: 50)
      ])
   }
   private func constrainIngredientTitleLabel(){
      contentView.addSubview(ingredientTitleLabel)
      ingredientTitleLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         ingredientTitleLabel.leadingAnchor.constraint(equalTo: ingredientPicture.trailingAnchor, constant: 10),
         ingredientTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
         ingredientTitleLabel.heightAnchor.constraint(equalToConstant: 50),        ingredientTitleLabel.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor)
      ])
   }
   private func constrainCheckButton(){
      contentView.addSubview(checkButton)
      checkButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
         checkButton.topAnchor.constraint(equalTo: contentView.topAnchor),
         checkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),         checkButton.widthAnchor.constraint(equalToConstant: 40)
      ])
   }
}
