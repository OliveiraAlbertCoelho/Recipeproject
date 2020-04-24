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
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
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
    lazy var recipeInfoTableView: UITableView = {
        let layout = UITableView()
        layout.register(DetailViewCell.self, forCellReuseIdentifier: "detailCell")
        layout.backgroundColor = .clear
        layout.delegate = self
        layout.dataSource = self
        return layout
    }()
    lazy var topHeaderView: UIView = {
       let header = UIView()
        header.backgroundColor = .clear
       return header
    }()
    lazy var servingsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var prepTimeLabel: UILabel = {
        let label = UILabel()
        return label
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
        view.backgroundColor = #colorLiteral(red: 0.2024219334, green: 0.3040059209, blue: 0.3669947386, alpha: 1)
    }
    private func setUpConstraints(){
        constrainTableView()
        constrainRecipeImage()
        //        constrainRecipeName()
        //        constrainFavoriteButtton()
    }
    
    
    //MARK: - Constraints
    
    private func constrainRecipeImage(){
        recipeInfoTableView.tableHeaderView = recipeImageView
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            recipeImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35)
        ])
    }
    private func constrainTableView(){
        view.addSubview(recipeInfoTableView)
        recipeInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeInfoTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            recipeInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            recipeInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            recipeInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
extension DetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DetailViewCell else {return UITableViewCell()}
        
        return cell
    }
}


