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
        image.alpha = 0.4
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
        constrainImageView()
        constrainRecipeImage()
        constrainRecipeName()
        constrainNumServingsLabel()
        constrainTimePrepLabel()
    }
    //MARK: - Constraints

    lazy var parallaxCenterYAnchor: NSLayoutConstraint = {
        self.recipeImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
    }()
    
    private func constrainImageView(){
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
            recipeName.topAnchor.constraint(equalTo: darkBackgroundView.topAnchor, constant: 0),
            recipeName.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
  
    private func constrainTimePrepLabel(){
        parallaxContainerView.addSubview(timePrepLabel)
        timePrepLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timePrepLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            timePrepLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -5),
            timePrepLabel.heightAnchor.constraint(equalTo: darkBackgroundView.heightAnchor, multiplier: 0.4),
            timePrepLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.30)
        ])
    }
    private func constrainNumServingsLabel(){
        parallaxContainerView.addSubview(numServingsLabel)
        numServingsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numServingsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            numServingsLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 5),
            numServingsLabel.heightAnchor.constraint(equalTo: darkBackgroundView.heightAnchor, multiplier: 0.4),
            numServingsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.30)
        ])
    }
    
}
