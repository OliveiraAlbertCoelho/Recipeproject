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
      label.font = .boldSystemFont(ofSize: 18)
      label.textAlignment = .center
      return label
   }()
   lazy var stepTitle: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.textAlignment = .left
      label.font = .systemFont(ofSize: 18)
      return label
   }()
   //MARK: - Regular Functions
   private func setUpView(){
      contentView.backgroundColor = #colorLiteral(red: 0.9489366412, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
      constrainStepTitle()
      constrainStepNumber()
   }
   //MARK: - Constraints
   private func constrainStepNumber(){
      contentView.addSubview(stepNumber)
      stepNumber.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         stepNumber.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
         stepNumber.trailingAnchor.constraint(equalTo: stepTitle.leadingAnchor, constant: 0),
         stepNumber.heightAnchor.constraint(equalToConstant: 19),
         stepNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
         
      ])
   }
   
   private func constrainStepTitle(){
      contentView.addSubview(stepTitle)
      stepTitle.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         stepTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
         stepTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
         stepTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
         stepTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      ])
   }
   
   
}
