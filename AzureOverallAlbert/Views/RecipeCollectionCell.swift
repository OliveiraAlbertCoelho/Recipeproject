//
//  RecipeCollectionCell.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class RecipeCollectionCell: UICollectionViewCell {
    
    //MARK: - Lifecycle
       override init(frame: CGRect) {
           super.init(frame: frame)
    
        //        constrainDarkView()
constrainRecipeImage()
        //        constrainRecipeName()
//        constrainNumServingsLabel()
//        constrainTimePrepLabel()
       }
    //MARK: - Variables
    lazy var parallaxImageHeight: NSLayoutConstraint = {
        self.recipeImage.heightAnchor.constraint(equalToConstant: 250)
    }()
    lazy var parallaxTopAnchor: NSLayoutConstraint = {
        self.recipeImage.topAnchor.constraint(equalTo: self.contentView.topAnchor)
    }()
    
  
    
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
   
    //MARK: - UI Objects
    lazy var recipeImage: UIImageView = {
       let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
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
    lazy var timePrepLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 16)
  label.textColor = .white
        return label
    }()
    lazy var numServingsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    lazy var darkBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6019103168)
        return view
    }()
    lazy var labelSeparator: UIView = {
        let view  = UIView()
        view.backgroundColor = .gray
        return view
    }()

    //MARK: - Regular Functions
   
    //MARK: - Constraints
  
    private func constrainRecipeImage(){
        contentView.addSubview(recipeImage)
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            parallaxImageHeight,
            parallaxTopAnchor,
            recipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
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
    private func constrainTimePrepLabel(){
        contentView.addSubview(timePrepLabel)
        timePrepLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timePrepLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            timePrepLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -5),
            timePrepLabel.heightAnchor.constraint(equalTo: darkBackgroundView.heightAnchor, multiplier: 0.4),
            timePrepLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.30)
        ])
    }
    private func constrainNumServingsLabel(){
        contentView.addSubview(numServingsLabel)
        numServingsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numServingsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            numServingsLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 5),
            numServingsLabel.heightAnchor.constraint(equalTo: darkBackgroundView.heightAnchor, multiplier: 0.4),
            numServingsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.30)
         
        ])
    }
  
}
