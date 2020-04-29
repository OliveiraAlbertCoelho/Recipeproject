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
      constrainexpandableSectionButton()
   }
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
      constrainInsideLabel()
      constrainexpandableSectionButton()
   }
   
   lazy var headerTitle: UILabel = {
      let label = UILabel()
      label.text = "fdsfds"
      label.textColor = .black
      label.textAlignment = .center
      return label
   }()
   lazy var expandableSectionButton : UIButton = {
      let button = UIButton()
      button.setImage(UIImage(systemName: "plus"), for: .normal)
      button.tintColor = .blue
      button.addTarget(self, action: #selector(expandableAction), for: .touchUpInside)
      button.isHidden = true
      return button
   }()
   
   //common func to init our view
   private func setupView() {
      backgroundColor = .clear
   }
   weak var delegate: ButtonProtocol?
   @objc func expandableAction (){
      delegate?.pressAction(tag: expandableSectionButton.tag)
   }
   private func constrainInsideLabel(){
      addSubview(headerTitle)
      headerTitle.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         headerTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         headerTitle.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 3)
      ])
   }
   private func constrainexpandableSectionButton(){
        addSubview(expandableSectionButton)
        expandableSectionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           expandableSectionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
           expandableSectionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
     }
   
}

