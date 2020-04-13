//
//  CartTableViewCell.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/31/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    //MARK: - Lifecycle
      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
              super.init(style: style, reuseIdentifier: reuseIdentifier)
//        constrainDarkView()
        //        constrainRecipeName()
        //        constrainitemsInCart()
        constrainRecipeView()
        constrainRecipeImage()

          }
         required init(coder aDecoder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }
    //MARK: - Variables
    lazy var parallaxImageHeight: NSLayoutConstraint = {
        self.recipeImage.heightAnchor.constraint(equalToConstant: 200)
    }()
    lazy var parallaxTopConstraint: NSLayoutConstraint = {
        self.recipeImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor )
    }()
    //MARK: - UI Objects
      lazy var recipeImage: UIImageView = {
         let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
          return image
      }()
    lazy var recipeView: UIView = {
        let view = UIView()
        return view
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
    private func constrainRecipeView(){
           contentView.addSubview(recipeView)
           recipeView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               recipeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               recipeView.topAnchor.constraint(equalTo: contentView.topAnchor),
               recipeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),               recipeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
           ])
       }
      private func constrainRecipeImage(){
          recipeView.addSubview(recipeImage)
          recipeImage.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
            parallaxImageHeight,
            recipeImage.leadingAnchor.constraint(equalTo: recipeView.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: recipeView.trailingAnchor),
            recipeImage.centerYAnchor.constraint(equalTo: recipeImage.centerYAnchor)
            
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
