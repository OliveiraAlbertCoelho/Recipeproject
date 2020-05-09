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
         setUpContentView()
    }
    required init(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   //MARK: - Variables
   var discoverData = [String](){
      didSet{
         discoverTypesCollectionView.reloadData()
      }
   }
   weak var delegate: DiscoverTypeProtocol?
   var searchStringType = Int()
   //MARK: - UI Objects
   lazy var discoverTypesCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .horizontal
      layout.minimumLineSpacing = 10
      let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
      cv.register(DiscoverTypesCollectionViewCell.self, forCellWithReuseIdentifier: "discoverCVC")
      cv.delegate = self
      cv.dataSource = self
      cv.backgroundColor = .clear
      cv.showsHorizontalScrollIndicator = false
      cv.clipsToBounds = true
      return cv
   }()
   //MARK: - Objc Functions
   //MARK: - Regular Functions
   private func setUpContentView(){
      contentView.backgroundColor = .clear
      constrainDiscoverTypesCollectionView()
   }
   //MARK: - Constraints
   private func constrainDiscoverTypesCollectionView(){
      contentView.addSubview(discoverTypesCollectionView)
      discoverTypesCollectionView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         discoverTypesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
         discoverTypesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         discoverTypesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         discoverTypesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      ])
   }
      
}
extension RecipesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return discoverData.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "discoverCVC", for: indexPath) as? DiscoverTypesCollectionViewCell else {return UICollectionViewCell()}
      let data = discoverData[indexPath.row]
      cell.titleLabel.text = data
//      cell.backgroundColor = indexPath.row % 2 == 0 ? .orange : .systemBlue
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: contentView.frame.width/2.5, height: contentView.frame.height)
   }
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      delegate?.pressAction(row: indexPath.row, section: searchStringType)
   }
}
