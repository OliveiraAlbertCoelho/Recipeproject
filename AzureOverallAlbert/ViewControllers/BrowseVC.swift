//
//  BrowseVC.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit
import SwiftUI
final class BrowseVC: UIViewController {
   //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      getRecipeData(searchInfo: searchStr, searchType: recipeFetchType ?? FetchRecipeType.query )
      setUpView()
   }
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      navigationController?.navigationBar.isHidden = false
   }
   var previousController: UIViewController?
   //MARK: - Variables
   var recipes = [RecipeWrapper](){
      didSet{
         recipeCV.reloadData()
      }
   }
   var searchStr = String()
   var recipeFetchType: FetchRecipeType?
   //MARK: - UI Objects
   lazy var recipeSearchBar: UISearchBar = {
      let searchBar = UISearchBar()
      searchBar.delegate = self
      searchBar.backgroundColor = .clear
      return searchBar
   }()
   lazy var appTitleLabel: UILabel = {
      let label = UILabel()
      label.text = "AzureOverall"
      label.font = .boldSystemFont(ofSize: 20)
      label.textAlignment = .center
      label.font = UIFont(name: "SUGARCOOKIES", size: 20)
      return label
   }()
   lazy var recipeCV: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
      cv.register(RecipeCollectionCell.self, forCellWithReuseIdentifier: "recipeCell")
      cv.backgroundColor = .white
      cv.delegate = self
      cv.isSpringLoaded = false
      cv.dataSource = self
      return cv
   }()
   //MARK: - Regular Functions
   private func setUpView(){
      setUpViewDesign()
      constrainRecipeSearchBar()
      constrainRecipeCV()
      recipeCV.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
      self.tabBarController?.delegate = self
   }
   private func setUpViewDesign(){
      navigationItem.titleView = appTitleLabel
      view.backgroundColor = #colorLiteral(red: 0.8344202638, green: 0.8393380046, blue: 0.8478055596, alpha: 1)
      
   }
   private func getRecipeData(searchInfo: String, searchType: FetchRecipeType){
      RecipeFetcher.manager.fetchRecipes(searchInfo: searchInfo, fetchRecipeType: searchType) { (result) in
         DispatchQueue.main.async {
            switch result{
            case .failure(let error):
               print(error)
            case .success(let recipes):
               self.recipes = recipes
            }
         }
      }
   }
   
   //MARK: - Constraints
   private func constrainRecipeSearchBar(){
      view.addSubview(recipeSearchBar)
      recipeSearchBar.translatesAutoresizingMaskIntoConstraints = false
      view.bringSubviewToFront(recipeSearchBar)
      NSLayoutConstraint.activate([
         recipeSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         recipeSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
         recipeSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
         recipeSearchBar.heightAnchor.constraint(equalToConstant: 50)
      ])
   }
   private func constrainRecipeCV(){
      view.addSubview(recipeCV)
      recipeCV.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         recipeCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         recipeCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
         recipeCV.topAnchor.constraint(equalTo: recipeSearchBar.bottomAnchor, constant: 0),
         recipeCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
      ])
   }
   
}
//MARK: - UICollectionView
extension BrowseVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return recipes.count
   }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as? RecipeCollectionCell else {return UICollectionViewCell()}
      let data = recipes[indexPath.row]
      ImageHelper.shared.fetchImage(urlString: data.recipeUrl ) { (result) in
         DispatchQueue.main.async {
            switch result{
            case .failure(let error):
               print(error)
            case .success(let data):
               cell.recipeImage.image = data
            }}
      }
      cell.updateParallaxOffset(CollectionViewBonds: collectionView.bounds)
      cell.recipeName.text = data.title
      cell.timePrepLabel.text = "\(data.readyInMinutes.description) Mins"
      cell.numServingsLabel.text = "\(data.servings.description) Servings"
      return cell
   }
   
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let cells = recipeCV.visibleCells as! [RecipeCollectionCell]
      cells.forEach { (cell) in
         cell.updateParallaxOffset(CollectionViewBonds: recipeCV.bounds)
      }

   }
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let cells = collectionView.visibleCells as! [RecipeCollectionCell]
      var cellImage: UIImage?
      for i in cells{
         if i.recipeName.text == recipes[indexPath.row].title{
            cellImage = i.recipeImage.image
         }
      }
      let data = recipes[indexPath.row]
      let detailVC = DetailVC()
      detailVC.recipeId = data.id
      detailVC.recipe = data
      detailVC.detailType = .regular
      detailVC.recipeImageView.image = cellImage
      navigationController?.pushViewController(detailVC, animated: true)
   }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: recipeCV.bounds.width, height: 280)
   }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
   }
}

//MARK: - UISearchBarDelegate
extension BrowseVC: UISearchBarDelegate{
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
      getRecipeData(searchInfo: searchBar.text ?? "", searchType: .query)
      
   }
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchBar.resignFirstResponder()
   }
}
//MARK: - UITabBarControllerDelegate
extension BrowseVC: UITabBarControllerDelegate {
   func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
      if previousController == viewController {
         recipeCV.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top
            , animated: true)
      }
      previousController = viewController
   }}


#if DEBUG
extension BrowseVC: UIViewControllerRepresentable {
   func makeUIViewController(context: Context) -> BrowseVC {
      let vc = BrowseVC()
      return vc
   }
   func updateUIViewController(_ uiViewController: BrowseVC, context: Context) {
   }
}

struct VCPreviews: PreviewProvider {
   static var previews: some View {
      BrowseVC()
   }
}
#endif


//      switch scrollView.contentOffset.y{
//      case let x  where  x <=  0.0 || x <= previousValue:
//         recipeSearchBar.isHidden = false
//      default:
//         recipeSearchBar.isHidden = true}
//      previousValue = scrollView.contentOffset.y
