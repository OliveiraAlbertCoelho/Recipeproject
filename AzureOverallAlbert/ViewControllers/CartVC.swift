//
//  CartVC.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class CartVC: UIViewController {
   //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      navigationItem.title = "Cart"
      view.backgroundColor = .white
      constraintCartTableView()
      
   }
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      getIngredients()
      
   }
   //MARK: - Variables
   var ingredients = [Ingredients](){
      didSet{
         headerTitle = Ingredients.recipeNameForHeader(ingredients)
      }}
   
   var headerTitle =  [String](){
      didSet{
         cartTableView.reloadData()
      }
   }
   //MARK: - UI Objects
   lazy var cartTableView: UITableView = {
      let layout = UITableView(frame: .zero, style: .plain)
      layout.register(IngredientCartCell.self, forCellReuseIdentifier: "ingredientCell")
      layout.delegate = self
      layout.allowsSelection = false
      layout.dataSource = self
      return layout
   }()
   //MARK: - Regular Functions
   private func getIngredients(){
      do{
         ingredients = try IngredientPersistence.manager.getIngredients()
      }catch{
         print(error)
      }
   }
   
   //MARK: - Constraints
   private func constraintCartTableView(){
      view.addSubview(cartTableView)
      cartTableView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         cartTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
         cartTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
         cartTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         cartTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      ])
   }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource{
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      let ingredientInSection = ingredients.filter { $0.fromRecipe == headerTitle[section]
      }
      return ingredientInSection.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)as? IngredientCartCell else {return UITableViewCell()}
      let filteredIngredient = ingredients.filter{$0.fromRecipe == headerTitle[indexPath.section]}
      let ingredient = filteredIngredient[indexPath.row]
      ImageHelper.shared.fetchImage(urlString: ingredient.ingredientImageUrl) { (result) in
         DispatchQueue.main.async {
            switch result{
            case .failure(let error):
               print(error)
            case .success(let image):
               cell.ingredientPicture.image = image
            }
         }}
      cell.checkButton.tag = ingredient.id
      cell.delegate = self
      cell.ingredientTitleLabel.text = ingredient.ingredientAmount
      return cell
   }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 60
   }
   func numberOfSections(in tableView: UITableView) -> Int {
      return headerTitle.count
   }
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return headerTitle[section]
   }
}
extension CartVC: ButtonProtocol{
   func pressAction(tag: Int, type: ButtonType) {
      do {try IngredientPersistence.manager.deleteIngredient(id: tag)}
      catch{
         print(error)
      }
      getIngredients()
   }
}
