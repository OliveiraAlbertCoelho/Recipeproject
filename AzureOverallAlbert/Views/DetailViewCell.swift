//
//  DetailViewCell.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/23/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class DetailViewCell: UITableViewCell {

        //MARK: - Lifecycle
          override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                  super.init(style: style, reuseIdentifier: reuseIdentifier)
            constrainDarkView()
            constrainRecipeImage()
            constrainRecipeName()
            constrainitemsInCart()
              }
             required init(coder aDecoder: NSCoder) {
                 fatalError("init(coder:) has not been implemented")
             }

        //MARK: - UI Objects
          lazy var recipeImage: UIImageView = {
             let image = UIImageView()
              return image
          }()
          lazy var recipeName: UILabel = {
              let label = UILabel()
              label.textAlignment = .left
              label.textColor = .white
              label.font = .boldSystemFont(ofSize: 20)
              label.numberOfLines = 0
              return label
          }()
          lazy var itemsInCart: UILabel = {
              let label = UILabel()
              label.textAlignment = .center
              label.font = .boldSystemFont(ofSize: 16)
            label.textColor = .white
              return label
          }()
        lazy var darkBackgroundView: UIView = {
               let view = UIView()
               view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6019103168)
               return view
           }()
          //MARK: - Regular Functions
        
          //MARK: - Constraints
          private func constrainRecipeImage(){
              contentView.addSubview(recipeImage)
              contentView.sendSubviewToBack(recipeImage)
              recipeImage.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([
                  recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor),
                  recipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                  recipeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                  recipeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
              ])
          }
          private func constrainRecipeName(){
              contentView.addSubview(recipeName)
              recipeName.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([
                  recipeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                  recipeName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.80),
                  recipeName.topAnchor.constraint(equalTo: darkBackgroundView.topAnchor, constant: 0),
                  recipeName.heightAnchor.constraint(equalToConstant: 60)
              ])
          }
          private func constrainDarkView(){
              contentView.addSubview(darkBackgroundView)
              darkBackgroundView.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([
              darkBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
              darkBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
             darkBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            darkBackgroundView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.30)
              ])
        }
        private func constrainitemsInCart(){
              contentView.addSubview(itemsInCart)
              itemsInCart.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([
              itemsInCart.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
              itemsInCart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 25),
            itemsInCart.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.10),
            itemsInCart.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.30)
              ])
        }
        
    }
