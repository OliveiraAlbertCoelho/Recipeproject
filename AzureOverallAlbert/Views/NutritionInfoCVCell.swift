//
//  NutritionInfoCVCell.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/25/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class NutritionInfoCVCell: UICollectionViewCell {
    
        //MARK: - Lifecycle
    override init(frame: CGRect) {
           super.init(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
       }
       
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Variables
    //MARK: - UI Objects
    lazy var nutritionTitleLabel: UILabel = {
       let label = UILabel()
        
    return label
    }()
    private func constrainNutritionTitleLabel(){
        contentView.addSubview(nutritionTitleLabel)
        nutritionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nutritionTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nutritionTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nutritionTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            nutritionTitleLabel.widthAnchor.constraint(equalToConstant: 30)
        
        ])
    }
    //MARK: - Objc Functions
    //MARK: - Regular Functions
    //MARK: - Constraints
}
