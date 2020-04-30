//
//  NutritionInfoCell.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/25/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class NutritionInfoCell: UITableViewCell {
   
   //MARK: - Lifecycle
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      constrainNutritionCV()
   }
   
   required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   //MARK: - Variables
   var recipe: RecipeWrapper?
   var nutritionInfo = [Nutrients](){
      didSet{
         nutritionCV.reloadData()
      }
   }
   
   //MARK: - Regular Functions
   //MARK: - UI Objects
   lazy var nutritionCV: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .horizontal
      layout.minimumLineSpacing = 10
      let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
      cv.register(NutritionCVC.self, forCellWithReuseIdentifier: "nutritionCVC")
      cv.delegate = self
      cv.dataSource = self
      cv.backgroundColor = .white
      cv.showsHorizontalScrollIndicator = false
      cv.clipsToBounds = true
      return cv
   }()
   //MARK: - Constraints
   private func constrainNutritionCV(){
      contentView.addSubview(nutritionCV)
      nutritionCV.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         nutritionCV.topAnchor.constraint(equalTo: contentView.topAnchor),
         nutritionCV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         nutritionCV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         nutritionCV.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         nutritionCV.heightAnchor.constraint(equalToConstant: 100)
      ])
   }
   
}
extension NutritionInfoCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
      return nutritionInfo.count
   }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = nutritionCV.dequeueReusableCell(withReuseIdentifier: "nutritionCVC", for: indexPath) as? NutritionCVC else { return UICollectionViewCell() }
      let data = nutritionInfo[indexPath.row]
      cell.nutrientTitle.text = data.title
      cell.nutrientAmount.text =  "\(data.amount)\(data.unit)"
      return cell
   }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: contentView.frame.width/4, height: 100)
   }
}
