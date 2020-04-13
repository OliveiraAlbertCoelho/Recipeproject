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
        getPersistedRecipe()
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
    lazy var itemsInCartLable: UILabel = {
        let label = UILabel()
        label.text = "Add to cart"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    lazy var cartStepper: UIStepper = {
        var stepper = UIStepper()
        stepper.autorepeat = true
        stepper.minimumValue = 0
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .touchUpInside)
        return stepper
    }()
    
    //MARK: - Objc Functions
    @objc private func stepperValueChanged(){

        if cartStepper.value == 0{
        itemsInCartLable.text = "Add to cart"}else{
        itemsInCartLable.text = "\(Int(cartStepper.value).description) Items"}
        recipe?.itemsInCart = Int(cartStepper.value)
        
        if let imageData = recipeImageView.image  {
            recipe?.persistedImage = imageData.jpegData(compressionQuality: 1)
        }
        
        if RecipePersistence.manager.checkIfSave(id: recipe?.id ?? 0){
            try? RecipePersistence.manager.editRecipe(id: recipe?.id ?? 0, newElement: recipe!)
            if cartStepper.value == 0{
                try? RecipePersistence.manager.deleteRecipe(id: recipe?.id ?? 0)
            }
        }else {
            try? RecipePersistence.manager.saveRecipe(info: recipe!)
        }
    }
    
    private func getPersistedRecipe(){
        
        if RecipePersistence.manager.checkIfSave(id: recipe?.id ?? 0){
            recipe = try? RecipePersistence.manager.getRecipe(id: recipe?.id ?? 0)
            if let recipInfo = recipe?.itemsInCart{
                itemsInCartLable.text = "\(Int(recipInfo).description) Items"
                cartStepper.value = Double(recipInfo)
                if cartStepper.value == 0{
                    itemsInCartLable.text = "Add to cart"
            }
        }}
    }
    
    //MARK: - Regular Functions
    private func setUpViewObjects(){
        recipeName.text = recipe?.title ?? "Title not found"
        if let recipeUrl = recipe?.recipeUrl{
            NetworkManager.manager.fetchData(urlString: recipeUrl) { (result) in
                DispatchQueue.main.async {
                    switch result{
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        self.recipeImageView.image = UIImage(data: data)
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
        constrainCartStepper()
        constrainItemsInCartLable()
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
    private func constrainCartStepper(){
        view.addSubview(cartStepper)
        cartStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cartStepper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cartStepper.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            cartStepper.widthAnchor.constraint(equalToConstant: 100),
            cartStepper.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    private func constrainItemsInCartLable(){
        view.addSubview(itemsInCartLable)
        itemsInCartLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemsInCartLable.bottomAnchor.constraint(equalTo: cartStepper.topAnchor, constant: -10),
            itemsInCartLable.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            itemsInCartLable.widthAnchor.constraint(equalToConstant: 150),
            itemsInCartLable.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
