//
//  DetailVC.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit
class DetailVC: UIViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewDesign()
        setUpConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViewObjects()
    }
    //MARK: - Variables
    var recipe: RecipeWrapper?
    var recipes = [RecipeWrapper]()
    //MARK: - UI Objects
    
    lazy var recipeImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    lazy var recipeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    lazy var favoriteButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    
    //MARK: - Objc Functions
    
    
   
    
    //MARK: - Regular Functions
    private func setUpViewObjects(){
        recipeName.text = recipe?.title ?? "Title not found"
        if let recipeUrl = recipe?.recipeUrl{
            ImageHelper.shared.fetchImage(urlString: recipeUrl) { (result) in
                DispatchQueue.main.async {
                    switch result{
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        self.recipeImageView.image = data
                    }
                }
            }
        }
    }
    private func setUpViewDesign(){
        view.backgroundColor = #colorLiteral(red: 0.773673594, green: 0.6645101905, blue: 0.4229003191, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.8, green: 0.6718267202, blue: 0.3871548772, alpha: 0.4229719606)
    }
    private func setUpConstraints(){
        constrainRecipeImage()
        constrainRecipeName()
        constrainFavoriteButtton()
    }
    
    
    //MARK: - Constraints
    
    private func constrainRecipeImage(){
        view.addSubview(recipeImageView)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            recipeImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
            
        ])
    }
    private func constrainRecipeName(){
        view.addSubview(recipeName)
        recipeName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeName.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 10),
            recipeName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            recipeName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            recipeName.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    private func constrainFavoriteButtton(){
        view.addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            favoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}
