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
      setUpViewConstraints()
   }
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   //MARK: - Variables
   
   var parallaxOffset: CGFloat = 0 {
      didSet{
         parallaxCenterYAnchor.constant = parallaxOffset
      }
   }
   
   
   //MARK: - UI Objects
   lazy var recipeImage: UIImageView = {
      let image = UIImageView()
      image.contentMode = .scaleAspectFill
      image.alpha = 0.8
      image.clipsToBounds = true
      return image
   }()
   lazy var recipeName: UILabel = {
      let label = addLabelShadow()
      label.textAlignment = .left
      label.font = .boldSystemFont(ofSize: 20)
      label.textColor = .white
      return label
   }()
   lazy var timePrepLabel: UILabel = {
      let label = addLabelShadow()
      label.textAlignment = .left
      label.font = .boldSystemFont(ofSize: 16)
      label.textColor = .white
      return label
   }()
   lazy var numServingsLabel: UILabel = {
      let label = addLabelShadow()
      label.textColor = .white
      label.font = .boldSystemFont(ofSize: 16)
      label.numberOfLines = 0
      return label
   }()
   
   lazy var labelSeparator: UIView = {
      let view  = UIView()
      view.backgroundColor = .gray
      return view
   }()
   lazy var parallaxContainerView: UIView = {
      let view = UIView()
      view.clipsToBounds = true
      return view
   }()
   
   //MARK: - Regular Functions
   
   func updateParallaxOffset(CollectionViewBonds bonds: CGRect){
      let center = CGPoint(x: ( bonds.midX), y: bonds.midY)
      let offsetFromCenter = CGPoint(x: center.x - self.center.x, y: center.y - self.center.y)
      let maxVerticalOffset = (bonds.height / 2) + (self.bounds.height / 2)
      let scaleFactor = 40 / maxVerticalOffset
      parallaxOffset = -offsetFromCenter.y * scaleFactor
   }
   
   private func setUpViewConstraints(){
      constrainParallaxContainerView()
      constrainRecipeImage()
      constrainTimePrepLabel()
      constrainNumServingsLabel()
      constrainRecipeName()
   }
   private func addLabelShadow() -> UILabel{
      let label = UILabel()
      label.layer.shadowOpacity = 0.8
      label.layer.shadowRadius = 0.5
      label.layer.shadowColor = UIColor.black.cgColor
      label.layer.shadowOffset = CGSize(width: 0.0, height: -0.5)
      label.backgroundColor = .clear
      return label
   }
   //MARK: - Constraints
   
   lazy var parallaxCenterYAnchor: NSLayoutConstraint = {
      self.recipeImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
   }()
   
   private func constrainParallaxContainerView(){
      contentView.addSubview(parallaxContainerView)
      parallaxContainerView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         parallaxContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         parallaxContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         parallaxContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         parallaxContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      ])
   }
   
   private func constrainRecipeImage(){
      parallaxContainerView.addSubview(recipeImage)
      recipeImage.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         parallaxCenterYAnchor,
         recipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         recipeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      ])
   }
   
   private func constrainRecipeName(){
      parallaxContainerView.addSubview(recipeName)
      recipeName.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         recipeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
         recipeName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.80),
         recipeName.bottomAnchor.constraint(equalTo: timePrepLabel.topAnchor , constant: -5),
         recipeName.heightAnchor.constraint(equalToConstant: 80)
      ])
   }
   
   private func constrainTimePrepLabel(){
      parallaxContainerView.addSubview(timePrepLabel)
      timePrepLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         timePrepLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
         timePrepLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -5),
         timePrepLabel.heightAnchor.constraint(equalToConstant: 20),
         timePrepLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.30)
      ])
   }
   private func constrainNumServingsLabel(){
      parallaxContainerView.addSubview(numServingsLabel)
      numServingsLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         numServingsLabel.bottomAnchor.constraint(equalTo: timePrepLabel.bottomAnchor, constant: 0),
         numServingsLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 5),
         numServingsLabel.heightAnchor.constraint(equalToConstant: 20),
         numServingsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.30)
      ])
   }
   
}
