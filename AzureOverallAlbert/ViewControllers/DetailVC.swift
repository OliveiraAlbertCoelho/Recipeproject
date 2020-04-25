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
        recipeInfoTableView.contentInset = UIEdgeInsets(top: 310, left: 0, bottom: 0, right: 0)
        
        setUpViewDesign()
        setUpConstraints()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViewObjects()
    }
    
    //MARK: - Variables
    var recipeInfo: RecipeInfo?
    var recipe: RecipeWrapper?
    var recipes = [RecipeWrapper]()
    //MARK: - UI Objects
    
    lazy var recipeImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        //        image.layer.cornerRadius = 60
        image.contentMode = .scaleAspectFill
        //        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return image
    }()
    lazy var recipeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
       label.font = UIFont(name: "Hiragino Mincho ProN", size:  20)
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
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 3))
        header.backgroundColor = #colorLiteral(red: 0.2024219334, green: 0.3040059209, blue: 0.3669947386, alpha: 1)
        return header
    }()
    lazy var servingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Hiragino Mincho ProN", size:  12)
        label.textAlignment = .left
        return label
    }()
    lazy var prepTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "Hiragino Mincho ProN", size:  12)
        return label
    }()
    lazy var lineSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        return line
    }()
 
  
    
    
    //MARK: - Regular Functions
    
    private func setUpViewObjects(){
        recipeName.text = recipe?.title ?? "Title not found"
        prepTimeLabel.text = "Prep Time: \(recipe?.readyInMinutes.description ?? "")"
        servingsLabel.text = "Servings: \(recipe?.servings.description ?? "")"
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
        RecipeInfoFetcher.manager.fetchRecipeInfo(recipeId: recipe?.id.description ?? "") { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let recipeInfo):
                    self.recipeInfo = recipeInfo
                }
            }
        }
    }
    private func setUpViewDesign(){
        view.backgroundColor = #colorLiteral(red: 0.2024219334, green: 0.3040059209, blue: 0.3669947386, alpha: 1)
    }
    private func setUpConstraints(){
        constrainTableView()
        constrainTopHeaderView()
        constrainRecipeImage()
        constrainRecipeName()
        constrainBottomLine()
        constrainServingSizeLabel()
        constrainPrepLabel()
    }
    
    
    //MARK: - Constraints
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
    
    lazy var recipeHeaderHeight: NSLayoutConstraint = {
          self.topHeaderView.heightAnchor.constraint(equalToConstant: 310)
      }()
    private func constrainTopHeaderView(){
        view.addSubview(topHeaderView)
        topHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            topHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            recipeHeaderHeight
        ])
    }
    
    private func constrainRecipeImage(){
        topHeaderView.addSubview(recipeImageView)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topHeaderView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: 0),
            recipeImageView.trailingAnchor.constraint(equalTo: topHeaderView.trailingAnchor, constant: 0),
            recipeImageView.heightAnchor.constraint(equalTo: topHeaderView.heightAnchor, multiplier: 0.75)
            
        ])
    }
  
    private func constrainRecipeName(){
        topHeaderView.addSubview(recipeName)
        recipeName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeName.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 5),
            recipeName.centerXAnchor.constraint(equalTo: topHeaderView.centerXAnchor, constant: 0),
            recipeName.heightAnchor.constraint(equalToConstant: 40),
            recipeName.widthAnchor.constraint(equalTo: topHeaderView.widthAnchor, multiplier: 0.5)
            
        ])
    }
    private func constrainBottomLine(){
        topHeaderView.addSubview(lineSeparator)
        lineSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineSeparator.topAnchor.constraint(equalTo: recipeName.bottomAnchor, constant: 0),
            lineSeparator.widthAnchor.constraint(equalTo: topHeaderView.widthAnchor, multiplier: 0.5),
            lineSeparator.heightAnchor.constraint(equalToConstant: 1),
            lineSeparator.centerXAnchor.constraint(equalTo: topHeaderView.centerXAnchor, constant: 0),
        ])
    }
    private func constrainServingSizeLabel(){
        topHeaderView.addSubview(servingsLabel)
        servingsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            servingsLabel.topAnchor.constraint(equalTo: lineSeparator.bottomAnchor, constant: 0),
            servingsLabel.widthAnchor.constraint(equalTo: topHeaderView.widthAnchor, multiplier: 0.3),
            servingsLabel.heightAnchor.constraint(equalToConstant: 15),
            servingsLabel.centerXAnchor.constraint(equalTo: topHeaderView.centerXAnchor, constant: -40),
        ])
    }
    private func constrainPrepLabel(){
        topHeaderView.addSubview(prepTimeLabel)
        prepTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            prepTimeLabel.topAnchor.constraint(equalTo: lineSeparator.bottomAnchor, constant: 0),
            prepTimeLabel.widthAnchor.constraint(equalTo: topHeaderView.widthAnchor, multiplier: 0.3),
            prepTimeLabel.heightAnchor.constraint(equalToConstant: 15),
            prepTimeLabel.centerXAnchor.constraint(equalTo: topHeaderView.centerXAnchor, constant: 40),
        ])
    }
  
}






extension DetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DetailViewCell else {return UITableViewCell()}
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 170), 400)
        recipeHeaderHeight.constant = height
    }
}




