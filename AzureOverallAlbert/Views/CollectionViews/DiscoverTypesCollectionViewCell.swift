//
//  DiscoverTypesCollectionViewCell.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 5/6/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class DiscoverTypesCollectionViewCell: UICollectionViewCell {
      //MARK: - Lifecycle
    override init(frame: CGRect) {
         super.init(frame: frame)
         setUpView()
      }
      
      required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
      }
   //MARK: - Variables
   //MARK: - UI Objects
   lazy var titleLabel: UILabel = {
      let label = UILabel()
      label.textColor = .white
      label.textAlignment = .center
      label.font = .boldSystemFont(ofSize: 20)
      return label
   }()
   //MARK: - Objc Functions
   //MARK: - Regular Functions
   private func setUpView(){
      constrainTitleLabel()
      contentView.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
   }
   private func constrainTitleLabel(){
      contentView.addSubview(titleLabel)
      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
         titleLabel.heightAnchor.constraint(equalToConstant: 40),
         titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
         titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
      ])
   }
   //MARK: - Constraints
}
