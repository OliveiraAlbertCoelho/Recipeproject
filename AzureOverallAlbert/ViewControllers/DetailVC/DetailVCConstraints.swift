//
//  DetailVCConstraints.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/27/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

extension DetailVC{
   //MARK: - Constraints
    func constrainTableView(){
      view.addSubview(recipeInfoTableView)
      recipeInfoTableView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         recipeInfoTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
         recipeInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         recipeInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
         recipeInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
   }
    func constrainBackButton(){
      topHeaderView.addSubview(backButton)
      backButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
         backButton.heightAnchor.constraint(equalToConstant: 30),
         backButton.widthAnchor.constraint(equalToConstant: 30)
         
      ])
   }
   
    func constrainTopHeaderView(){
      view.addSubview(topHeaderView)
      topHeaderView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         topHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
         topHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         topHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
         recipeHeaderHeight
      ])
   }
   
    func constrainRecipeImage(){
      topHeaderView.addSubview(recipeImageView)
      recipeImageView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         recipeImageView.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 0),
         recipeImageView.bottomAnchor.constraint(equalTo: bottomHeaderView.topAnchor),
         recipeImageView.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: 0),
         recipeImageView.trailingAnchor.constraint(equalTo: topHeaderView.trailingAnchor, constant: 0),
         
      ])
   }
    func constrainBottomHeaderView(){
      topHeaderView.addSubview(bottomHeaderView)
      bottomHeaderView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         bottomHeaderView.heightAnchor.constraint(equalToConstant: 70),
         bottomHeaderView.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: 0),
         bottomHeaderView.trailingAnchor.constraint(equalTo: topHeaderView.trailingAnchor, constant: 0),
         bottomHeaderView.bottomAnchor.constraint(equalTo: topHeaderView.bottomAnchor, constant: 0)
         
      ])
   }
   
    func constrainRecipeName(){
      bottomHeaderView.addSubview(recipeName)
      recipeName.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         recipeName.bottomAnchor.constraint(equalTo: lineSeparator.topAnchor, constant: -3),
         recipeName.centerXAnchor.constraint(equalTo: topHeaderView.centerXAnchor, constant: 0),
         recipeName.heightAnchor.constraint(equalToConstant: 40),
         recipeName.widthAnchor.constraint(equalTo: bottomHeaderView.widthAnchor, multiplier: 0.5)
         
      ])
   }
    func constrainBottomLine(){
      bottomHeaderView.addSubview(lineSeparator)
      lineSeparator.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         lineSeparator.bottomAnchor.constraint(equalTo: servingsLabel.topAnchor, constant: -2),
         lineSeparator.widthAnchor.constraint(equalTo: bottomHeaderView.widthAnchor, multiplier: 0.5),
         lineSeparator.heightAnchor.constraint(equalToConstant: 1),
         lineSeparator.centerXAnchor.constraint(equalTo: bottomHeaderView.centerXAnchor, constant: 0),
      ])
   }
    func constrainServingSizeLabel(){
      bottomHeaderView.addSubview(servingsLabel)
      servingsLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         servingsLabel.bottomAnchor.constraint(equalTo: bottomHeaderView.bottomAnchor, constant: -8),
         servingsLabel.widthAnchor.constraint(equalTo: bottomHeaderView.widthAnchor, multiplier: 0.3),
         servingsLabel.heightAnchor.constraint(equalToConstant: 15),
         servingsLabel.centerXAnchor.constraint(equalTo: bottomHeaderView.centerXAnchor, constant: -40),
      ])
   }
    func constrainPrepLabel(){
      bottomHeaderView.addSubview(prepTimeLabel)
      prepTimeLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         prepTimeLabel.bottomAnchor.constraint(equalTo: bottomHeaderView.bottomAnchor, constant: -8),
         prepTimeLabel.widthAnchor.constraint(equalTo: bottomHeaderView.widthAnchor, multiplier: 0.3),
         prepTimeLabel.heightAnchor.constraint(equalToConstant: 15),
         prepTimeLabel.centerXAnchor.constraint(equalTo: bottomHeaderView.centerXAnchor, constant: 40),
      ])
   }
    func constrainLottieView(){
        view.addSubview(lottieView)
        view.bringSubviewToFront(lottieView)
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
              lottieView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
              lottieView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
              lottieView.heightAnchor.constraint(equalToConstant: 60),
              lottieView.widthAnchor.constraint(equalToConstant: 60)
           ])
        
     }
      func constrainButtonFavorite(){
        lottieView.addSubview(favoriteButton)
         lottieView.bringSubviewToFront(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           favoriteButton.trailingAnchor.constraint(equalTo: lottieView.trailingAnchor, constant: 0),
           favoriteButton.topAnchor.constraint(equalTo: lottieView.topAnchor, constant: 0),
           favoriteButton.bottomAnchor.constraint(equalTo: lottieView.bottomAnchor),
           favoriteButton.leadingAnchor.constraint(equalTo: lottieView.leadingAnchor),
        
        ])
     }
}

