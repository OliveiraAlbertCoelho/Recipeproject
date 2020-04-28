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
    }
   
    //MARK: - Variables
    var recipes = [RecipeWrapper](){
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
        view.backgroundColor = #colorLiteral(red: 0.8, green: 0.6718267202, blue: 0.3871548772, alpha: 0.4229719606)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.8, green: 0.6718267202, blue: 0.3871548772, alpha: 0.4229719606)
        constrainFavoritesCV()
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
        let bonds = favoritesCV.bounds
        for cell in cells {
            cell.updateParallaxOffset(CollectionViewBonds: bonds)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.recipe = recipes[indexPath.row]
        detailVC.modalPresentationStyle = .fullScreen
     navigationController?.pushViewController(detailVC, animated: true)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: favoritesCV.bounds.width, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
