//
//  SectionsHeaderVIew.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/26/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {
   
   
   override init(reuseIdentifier: String?) {
      super.init(reuseIdentifier: reuseIdentifier)
      constrainTitleLabel()
   }
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   var headerType: ButtonType?{
      didSet{
         switch self.headerType {
         case .headerSec0:
            constrainExpandableSectionButton()
            headerTitle.text = "Nutrition"
            self.addGestureRecognizer(headerViewTap)
         default:
            headerTitle.text = "Ingredients"
            constrainSelectAllItemsButton()
         }
      }
   }

   lazy var headerViewTap: UITapGestureRecognizer = {
      let tapGesture = UITapGestureRecognizer()
      return tapGesture
   }()
   
   lazy var headerTitle: UILabel = {
      let label = UILabel()
      label.textColor = .orange
      label.textAlignment = .center
      label.font = .boldSystemFont(ofSize: 18)
      return label
   }()
   lazy var expandableSectionButton : UIButton = {
      let button = UIButton()
      button.tintColor = .orange
      button.isEnabled = false
      button.setImage(UIImage(systemName: "plus"), for: .normal)
      return button
   }()
   lazy var selectAllButton : UIButton = {
      let button = UIButton()
      button.setTitle("Select All", for: .normal)
      button.setTitleColor(.orange, for: .normal)
      button.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside)
      return button
   }()
   weak var delegate: ButtonProtocol?
   
   @objc func selectAllAction(){
      delegate?.pressAction(tag: expandableSectionButton.tag, type: .headerSec1)
   }
   private func constrainTitleLabel(){
      addSubview(headerTitle)
      headerTitle.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         headerTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         headerTitle.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 3)
      ])
   }
   private func constrainExpandableSectionButton(){
      addSubview(expandableSectionButton)
      expandableSectionButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         expandableSectionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         expandableSectionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
      ])
   }
   private func constrainSelectAllItemsButton(){
      addSubview(selectAllButton)
      selectAllButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         selectAllButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         selectAllButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
      ])
   }
}


