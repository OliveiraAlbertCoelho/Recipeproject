//
//  CartVC.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit
class CartVC: UIViewController {
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
            cartTableVC.reloadData()
        }
    }
   
    //MARK: - UI Objects
    lazy var cartTableVC: UITableView = {
        let layout = UITableView()
        layout.register(CartTableViewCell.self, forCellReuseIdentifier: "cartCell")
        layout.backgroundColor = .clear
        layout.delegate = self
        layout.dataSource = self
        return layout
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
        constrainCartTableVC()
    }
    //MARK: - Constraints
    private func constrainCartTableVC(){
        view.addSubview(cartTableVC)
        cartTableVC.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cartTableVC.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartTableVC.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartTableVC.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartTableVC.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDelegates
extension CartVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(recipes.count)
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cartTableVC.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? CartTableViewCell else {return UITableViewCell()}
        let data = recipes[indexPath.row]
        if let imageData = data.persistedImage{
            cell.recipeImage.image = UIImage(data: imageData)
        }
        cell.parallaxImageHeight.constant = self.parallaxImageHeight
        cell.parallaxTopConstraint.constant = self.parralaxOffset(newOffsetY: cartTableVC.contentOffset.y, cell: cell)
        cell.itemsInCart.text = "\(data.itemsInCart?.description ?? 0.description) Items"
        cell.recipeName.text = data.title
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return parallaxImageHeight
    }
    
    func parralaxOffset(newOffsetY: CGFloat, cell: UITableViewCell) -> CGFloat{
        return (newOffsetY - cell.frame.origin.y) / parallaxImageHeight * parallaxOffsetSpeed
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let OffsetY = cartTableVC.contentOffset.y
        for cell in cartTableVC.visibleCells as! [CartTableViewCell]{
            cell.parallaxTopConstraint.constant = parralaxOffset(newOffsetY: OffsetY, cell: cell)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.recipe = recipes[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
