//
//  BrowseVC.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit
class BrowseVC: UIViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        recipeCV.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
    }
    
    
    
    //MARK: - Variables
    var recipes = [RecipeWrapper](){
        didSet{
            recipeCV.reloadData()
        }
    }
    //MARK: - UI Objects
    lazy var recipeSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.barTintColor = #colorLiteral(red: 0.2024219334, green: 0.3040059209, blue: 0.3669947386, alpha: 1)
        return searchBar
    }()
    lazy var recipeCV: UICollectionView = {
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
    private func setUpView(){
        setUpViewDesign()
        constrainRecipeSearchBar()
        constrainRecipeCV()
    }
    private func setUpViewDesign(){
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1269915402, green: 0.241232276, blue: 0.3125525415, alpha: 1)
        navigationItem.title = "AzureOverall"
        view.backgroundColor = #colorLiteral(red: 0.1957240403, green: 0.2921617031, blue: 0.3509372175, alpha: 1)
    }
    private func getRecipeData(searchInfo: String){
        RecipeFetcher.manager.fetchRecipes(searchInfo: searchInfo) { (result) in
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
        NSLayoutConstraint.activate([
            recipeSearchBar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            recipeSearchBar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0),
            recipeSearchBar.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            recipeSearchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
    }
    private func constrainRecipeCV(){
        view.addSubview(recipeCV)
        recipeCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeCV.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            recipeCV.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0),
            recipeCV.topAnchor.constraint(equalToSystemSpacingBelow: recipeSearchBar.bottomAnchor, multiplier: 0),
            recipeCV.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0)
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
        let bonds = recipeCV.bounds
        for cell in cells {
            cell.updateParallaxOffset(CollectionViewBonds: bonds)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.recipe = recipes[indexPath.row]
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true, completion: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: recipeCV.bounds.width, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
//MARK: - UISearchBarDelegate
extension BrowseVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        getRecipeData(searchInfo: searchBar.text ?? "")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
