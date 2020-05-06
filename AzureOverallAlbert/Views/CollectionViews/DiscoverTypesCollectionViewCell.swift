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
      return label
   }()
   //MARK: - Objc Functions
   //MARK: - Regular Functions
   private func setUpView(){
      contentView.backgroundColor = .white
      constrainTitleLabel()
      
   }
   private func constrainTitleLabel(){
      contentView.addSubview(titleLabel)
      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
         titleLabel.heightAnchor.constraint(equalToConstant: 40),
         titleLabel.widthAnchor.constraint(equalToConstant: 40)
      ])
   }
   //MARK: - Constraints
}
