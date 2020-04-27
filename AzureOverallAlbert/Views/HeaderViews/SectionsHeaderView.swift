//
//  SectionsHeaderVIew.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/26/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class SectionHeaderView: UIView {
   override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
      constrainInsideLabel()
   }
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
   }
   
   lazy var headerTitle: UILabel = {
      let label = UILabel()
      label.text = "fdsfds"
      label.textColor = .black
      label.textAlignment = .center
      return label
   }()
   
   //common func to init our view
   private func setupView() {
      backgroundColor = .clear
   }
   
   private func constrainInsideLabel(){
      addSubview(headerTitle)
      headerTitle.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         headerTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         headerTitle.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 3)
      ])
   }
   
}

