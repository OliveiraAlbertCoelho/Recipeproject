//
//  RecipesTableViewCell.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 5/6/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
   //MARK: - Lifecycle
      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   //MARK: - Variables
   //MARK: - UI Objects
   lazy var discoverTypesCollectionView: UICollectionView = {
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
   //MARK: - Objc Functions
   //MARK: - Regular Functions
   private func setUpContentView(){
      contentView.backgroundColor = .white
      
   }
   //MARK: - Constraints
      
}
extension RecipesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      <#code#>
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      <#code#>
   }
   
   
}
