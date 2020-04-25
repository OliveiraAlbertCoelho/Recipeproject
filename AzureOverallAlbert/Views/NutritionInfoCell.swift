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
           let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
           cv.register(NutritionInfoCVCell.self, forCellWithReuseIdentifier: "nutritionCVC")
           cv.backgroundColor = .clear
           cv.backgroundColor = .clear
           cv.delegate = self
           cv.dataSource = self
           cv.showsHorizontalScrollIndicator = false
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
        ])
    }

}
extension NutritionInfoCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nutritionInfo.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nutritionCVC", for: indexPath) as? NutritionInfoCVCell else {return UICollectionViewCell() }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width/3, height: contentView.frame.height)
    }
}
