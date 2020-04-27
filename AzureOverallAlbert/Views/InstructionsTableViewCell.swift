//
//  InstructionsTableViewCell.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/26/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class InstructionsTableViewCell: UITableViewCell {

    //MARK: - Lifecycle
       
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
          return label
       }()
       lazy var stepName: UILabel = {
          let label = UILabel()
         label.numberOfLines = 0
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
          contentView.addSubview(stepNumber)
          stepNumber.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
             stepNumber.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
             stepNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
             stepNumber.heightAnchor.constraint(equalToConstant: 50),
             stepNumber.widthAnchor.constraint(equalToConstant: 50)
          ])
       }
       
       private func constrainIngredientTitleLabel(){
          contentView.addSubview(stepName)
          stepName.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
             stepName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
             stepName.leadingAnchor.constraint(equalTo: stepNumber.trailingAnchor, constant: 0),
             stepName.widthAnchor.constraint(equalToConstant: 300),
             stepName.heightAnchor.constraint(equalToConstant: 60),
          ])
       }
       
       
    }
