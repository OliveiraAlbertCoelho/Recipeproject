//
//  SectionsHeaderVIew.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/26/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class SectionHeaderView: UIView {
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
   override init(frame: CGRect) {
      super.init(frame: frame)
      constrainInsideLabel()


   }
   lazy var headerTap: UITapGestureRecognizer = {
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer(gestureRecognizer:)))
      return tapGesture
   }()
   var headerType: ButtonType?{
      didSet{
         switch self.headerType {
         case .headerSec0:
            constrainExpandableSectionButton()
            headerTitle.text = "Nutrition"
            self.addGestureRecognizer(headerTap)
         default:
            headerTitle.text = "Ingredients"
            constrainselectAllButton()
         }
      }
   }
   @objc func TapGestureRecognizer(gestureRecognizer: UIGestureRecognizer) {
   buttonState = !buttonState

   }
   
   var buttonState = true{
      didSet{
         var type = String()
         type = buttonState ?  "plus" :  "minus"
         expandableSectionButton.setImage(UIImage(systemName: type), for: .normal)
      }
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
      button.tintColor = .orange
      button.isEnabled = false
      button.setImage(UIImage(systemName: "plus"), for: .normal)
      return button
   }()
   lazy var selectAllButton : UIButton = {
      let button = UIButton()
      button.setTitle("Select All", for: .normal)
      button.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
      button.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside)
      return button
   }()
   
   weak var delegate: ButtonProtocol?
   
   @objc func selectAllAction(){
      delegate?.pressAction(tag: expandableSectionButton.tag, type: .headerSec1)
   }
   private func constrainInsideLabel(){
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
   private func constrainselectAllButton(){
      addSubview(selectAllButton)
      selectAllButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         selectAllButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         selectAllButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
      ])
   }
}

