//
//  CartVC.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit
//import Kingfisher
final class FavoritesVC: UIViewController {
   //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      setUpView()
   }
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      loadRecipes()
      navigationController?.navigationBar.isHidden = false
   }
   
   
   //MARK: - Variables
   var recipes = [RecipeInfo](){
      didSet{
         favoritesCV.reloadData()
      }
   }
   
   //MARK: - UI Objects
   lazy var favoritesCV: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
      cv.register(RecipeCollectionCell.self, forCellWithReuseIdentifier: "recipeCell")
      cv.backgroundColor = .clear
      cv.delegate = self
      cv.dataSource = self
      return cv
   }()
   
   //MARK: - Regular Functions
   private func loadRecipes(){
      do {
         recipes = try RecipePersistence.manager.getRecipes().reversed()
      }catch{
         print(error)
      }
   }
   
   private func setUpView(){
      constrainFavoritesCV()
      view.backgroundColor = #colorLiteral(red: 0.8344202638, green: 0.8393380046, blue: 0.8478055596, alpha: 1)
      navigationItem.title = "Favorites"
   }
   
   //MARK: - Constraints
   private func constrainFavoritesCV(){
      view.addSubview(favoritesCV)
      favoritesCV.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         favoritesCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         favoritesCV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         favoritesCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         favoritesCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      ])
   }
}

//MARK: - UiCollectionViewDelegates
extension FavoritesVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return recipes.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as? RecipeCollectionCell else {return UICollectionViewCell()}
      let data = recipes[indexPath.row]
      cell.recipeImage.image = UIImage(data: data.persistedImage!)
      cell.updateParallaxOffset(CollectionViewBonds: collectionView.bounds)
      cell.recipeName.text = data.title
      cell.timePrepLabel.text = "\(data.readyInMinutes.description) Mins"
      cell.numServingsLabel.text = "\(data.servings.description) Servings"
      return cell
   }
   
   
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let cells = favoritesCV.visibleCells as! [RecipeCollectionCell]
      for cell in cells {
         cell.updateParallaxOffset(CollectionViewBonds: favoritesCV.bounds)
      }
   }
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let detailVC = DetailVC()
      let data = recipes[indexPath.row]
      detailVC.recipeInfo = data
      detailVC.recipeId = data.id
      if let recipeImage = data.persistedImage{
         detailVC.recipeImageView.image = UIImage(data: recipeImage)
      }
      navigationController?.pushViewController(detailVC, animated: true)
   }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      print(favoritesCV.bounds.width)
      return CGSize(width: favoritesCV.bounds.width, height: 250)
   }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
   }
   
}
