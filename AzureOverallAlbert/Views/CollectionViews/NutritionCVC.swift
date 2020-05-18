//
//  NutritionCVC.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/25/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class NutritionCVC: UICollectionViewCell {
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      constrainNutrientTitle()
      constrainNutrientAmount()
//      contentView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
      contentView.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
      contentView.layer.cornerRadius = 50
      contentView.layer.masksToBounds = true
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   lazy var nutrientTitle: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.textAlignment = .center
      label.font = UIFont(name: "Hiragino Mincho ProN", size:  12)
      label.font = .boldSystemFont(ofSize: 12)
      return label
   }()
   lazy var nutrientAmount: UILabel = {
      let label = UILabel()
      label.font = UIFont(name: "Hiragino Mincho ProN", size:  12)
      label.textAlignment = .center
      return label
   }()
   
   
   private func constrainNutrientTitle(){
      contentView.addSubview(nutrientTitle)
      nutrientTitle.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         nutrientTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         nutrientTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
         nutrientTitle.heightAnchor.constraint(equalToConstant: 20),
         nutrientTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor)
      ])
   }
   private func constrainNutrientAmount(){
      contentView.addSubview(nutrientAmount)
      nutrientAmount.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         nutrientAmount.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         nutrientAmount.topAnchor.constraint(equalTo: nutrientTitle.bottomAnchor, constant: 5),
         nutrientAmount.heightAnchor.constraint(equalToConstant: 20),
         nutrientAmount.widthAnchor.constraint(equalTo: contentView.widthAnchor)
      ])
   }
   
}


