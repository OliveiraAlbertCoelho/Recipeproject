//
//  DetailVC.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit
import SwiftUI

final class DetailVC: UIViewController {
   //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      recipeInfoTableView.contentInset = UIEdgeInsets(top: 310, left: 0, bottom: 0, right: 0)
      setUpViewDesign()
      setUpConstraints()
      setUpViewObjects()
      view.addGestureRecognizer(swipeRight)
      self.constrainTableView()

      
   }
   let recipeId = "324694"
   lazy var swipeRight: UISwipeGestureRecognizer = {
      let swipe = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
      swipe.direction = UISwipeGestureRecognizer.Direction.right
      return swipe
   }()
   
   @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
      let transition = CATransition()
      transition.duration = 0.3
      transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
      transition.type = CATransitionType.push
      transition.subtype = CATransitionSubtype.fromLeft
      view.window!.layer.add(transition, forKey: nil)
      dismiss(animated: false, completion: nil)
   }
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
   }
   
   //MARK: - Variables
   var recipeInfo: RecipeInfo?{
      didSet{
         recipeInfoTableView.reloadData()
         setUpRecipeView()
      }
   }
   var recipe: RecipeWrapper?
   //MARK: - UI Objects
   var headerHeight: CGFloat = 35
   lazy var recipeImageView: UIImageView = {
      let image = UIImageView()
      image.clipsToBounds = true
      image.layer.cornerRadius = 45
      image.contentMode = .scaleAspectFill
      image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
      return image
   }()
   lazy var recipeName: UILabel = {
      let label = UILabel()
      label.textAlignment = .center
      label.numberOfLines = 0
      label.font = UIFont(name: "Hiragino Mincho ProN", size:  20)
      label.textColor = .black
      return label
   }()
   lazy var favoriteButton: UIButton = {
      let button = UIButton()
      button.setImage(UIImage(systemName: "heart"), for: .normal)
      return button
   }()
   lazy var recipeInfoTableView: UITableView = {
      let layout = UITableView(frame: .zero, style: .grouped)
      layout.register(NutritionInfoCell.self, forCellReuseIdentifier: "nutriCell")
      layout.register(RecipeIngredientsCell.self, forCellReuseIdentifier: "recipIngri")
      layout.register(InstructionsTableViewCell.self, forCellReuseIdentifier: "instructionCell")
      layout.separatorStyle = UITableViewCell.SeparatorStyle.none
      layout.backgroundColor = #colorLiteral(red: 0.9489366412, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
      layout.delegate = self
      layout.dataSource = self
      return layout
   }()
   lazy var topHeaderView: UIView = {
      let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 3))
      header.backgroundColor = #colorLiteral(red: 0.9489366412, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
      return header
   }()
   lazy var servingsLabel: UILabel = {
      let label = UILabel()
      label.font = UIFont(name: "Hiragino Mincho ProN", size:  12)
      label.textAlignment = .left
      label.textColor = .black
      return label
   }()
   lazy var prepTimeLabel: UILabel = {
      let label = UILabel()
      label.textAlignment = .right
      label.textColor = .black
      label.font = UIFont(name: "Hiragino Mincho ProN", size:  12)
      return label
   }()
   lazy var lineSeparator: UIView = {
      let line = UIView()
      line.backgroundColor = .black
      return line
   }()
   lazy var bottomHeaderView: UIView = {
      let view = UIView()
      return view
   }()
   lazy var backButton: UIButton = {
      let button = UIButton()
      button.setImage(UIImage(systemName: "arrowshape.turn.up.left.fill"), for: .normal)
      button.tintColor = .black
      button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
      button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
      button.layer.shadowOffset = CGSize(width: 0, height: 3)
      button.layer.shadowOpacity = 1.0
      button.layer.shadowRadius = 10.0
      button.layer.masksToBounds = false
      return button
   }()
   
   //MARK: - Regular Functions
   @objc private func goBackAction(){
      dismiss(animated: true, completion: nil)
   }
   private func setUpRecipeView(){
      recipeName.text = recipeInfo?.title ?? "not found"
           prepTimeLabel.text = "Prep Time: \(recipeInfo?.readyInMinutes.description ?? "")"
           servingsLabel.text = "Servings: \(recipeInfo?.servings.description ?? "")"
           if let recipeUrl = recipeInfo?.recipeUrl{
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
   private func setUpViewObjects(){
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
      view.backgroundColor = #colorLiteral(red: 0.9489366412, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
   }
   private func setUpConstraints(){
      constrainTopHeaderView()
      constrainBottomHeaderView()
      constrainPrepLabel()
      constrainServingSizeLabel()
      constrainBottomLine()
      constrainRecipeName()
      constrainRecipeImage()
      constrainBackButton()
   }
   //MARK: - Constraints
   private func constrainTableView(){
      view.addSubview(recipeInfoTableView)
      view.sendSubviewToBack(recipeInfoTableView)
      recipeInfoTableView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         recipeInfoTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
         recipeInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         recipeInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
         recipeInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
   }
   private func constrainBackButton(){
      topHeaderView.addSubview(backButton)
      view.bringSubviewToFront(backButton)
      backButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
         backButton.heightAnchor.constraint(equalToConstant: 50),
         backButton.widthAnchor.constraint(equalToConstant: 50)
         
      ])
   }
   
   lazy var recipeHeaderHeight: NSLayoutConstraint = {
      self.topHeaderView.heightAnchor.constraint(equalToConstant: 310)
   }()
   private func constrainTopHeaderView(){
      view.addSubview(topHeaderView)
      view.bringSubviewToFront(topHeaderView)
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
         recipeImageView.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 0),
         recipeImageView.bottomAnchor.constraint(equalTo: bottomHeaderView.topAnchor),
         recipeImageView.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: 0),
         recipeImageView.trailingAnchor.constraint(equalTo: topHeaderView.trailingAnchor, constant: 0),
         
      ])
   }
   private func constrainBottomHeaderView(){
      topHeaderView.addSubview(bottomHeaderView)
      bottomHeaderView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         bottomHeaderView.heightAnchor.constraint(equalToConstant: 70),
         bottomHeaderView.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: 0),
         bottomHeaderView.trailingAnchor.constraint(equalTo: topHeaderView.trailingAnchor, constant: 0),
         bottomHeaderView.bottomAnchor.constraint(equalTo: topHeaderView.bottomAnchor, constant: 0)
         
      ])
   }
   
   private func constrainRecipeName(){
      bottomHeaderView.addSubview(recipeName)
      recipeName.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         recipeName.bottomAnchor.constraint(equalTo: lineSeparator.topAnchor, constant: -3),
         recipeName.centerXAnchor.constraint(equalTo: topHeaderView.centerXAnchor, constant: 0),
         recipeName.heightAnchor.constraint(equalToConstant: 40),
         recipeName.widthAnchor.constraint(equalTo: bottomHeaderView.widthAnchor, multiplier: 0.5)
         
      ])
   }
   private func constrainBottomLine(){
      bottomHeaderView.addSubview(lineSeparator)
      lineSeparator.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         lineSeparator.bottomAnchor.constraint(equalTo: servingsLabel.topAnchor, constant: -2),
         lineSeparator.widthAnchor.constraint(equalTo: bottomHeaderView.widthAnchor, multiplier: 0.5),
         lineSeparator.heightAnchor.constraint(equalToConstant: 1),
         lineSeparator.centerXAnchor.constraint(equalTo: bottomHeaderView.centerXAnchor, constant: 0),
      ])
   }
   private func constrainServingSizeLabel(){
      bottomHeaderView.addSubview(servingsLabel)
      servingsLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         servingsLabel.bottomAnchor.constraint(equalTo: bottomHeaderView.bottomAnchor, constant: -8),
         servingsLabel.widthAnchor.constraint(equalTo: bottomHeaderView.widthAnchor, multiplier: 0.3),
         servingsLabel.heightAnchor.constraint(equalToConstant: 15),
         servingsLabel.centerXAnchor.constraint(equalTo: bottomHeaderView.centerXAnchor, constant: -40),
      ])
   }
   private func constrainPrepLabel(){
      bottomHeaderView.addSubview(prepTimeLabel)
      prepTimeLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         prepTimeLabel.bottomAnchor.constraint(equalTo: bottomHeaderView.bottomAnchor, constant: -8),
         prepTimeLabel.widthAnchor.constraint(equalTo: bottomHeaderView.widthAnchor, multiplier: 0.3),
         prepTimeLabel.heightAnchor.constraint(equalToConstant: 15),
         prepTimeLabel.centerXAnchor.constraint(equalTo: bottomHeaderView.centerXAnchor, constant: 40),
      ])
   }
   
   
}

extension DetailVC: UITableViewDelegate, UITableViewDataSource{
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      switch section{
      case 0:
         return 1
      case 1:
         return recipeInfo?.extendedIngredients.count ?? 0
      case 2:
         return recipeInfo?.analyzedInstructions.first?.steps.count ?? 0
      default:
         return 0
      }
   }
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let view = SectionHeaderView()
      switch  section {
      case 0:
         view.headerTitle.text = "Nutrition"
      case 1:
         view.headerTitle.text = "Ingredients"
      case 2:
         view.headerTitle.text = "Preparation"
      default:
         view.headerTitle.text = ""
      }
      
      return view
   }
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return headerHeight
   }
   func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      return .leastNormalMagnitude
   }
   func numberOfSections(in tableView: UITableView) -> Int {
      return 3
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      switch indexPath.section{
      case 0:
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "nutriCell", for: indexPath) as? NutritionInfoCell else { return UITableViewCell() }
         if let recipeinf = recipeInfo{
            cell.nutritionInfo = recipeinf.nutrition.nutrients
         }
         return cell
         
      case 1:
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipIngri", for: indexPath) as? RecipeIngredientsCell else {return UITableViewCell()}
         let data = recipeInfo?.extendedIngredients[indexPath.row]
         cell.ingredientTitleLabel.text = data?.name
         return cell
         default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "instructionCell", for: indexPath) as? InstructionsTableViewCell else {return UITableViewCell()}
            let data = recipeInfo?.analyzedInstructions.first?.steps[indexPath.row]
            cell.stepNumber.text = data?.number.description
            cell.stepName.text = data?.step
            return cell
         }
      }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      switch indexPath.section{
      case 0:
         return 100
      case 1:
         return 50
      case 2:
         return 60
      default:
         return 0
      }
   }
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let y = 300 - (scrollView.contentOffset.y + 300)
      let height = min(max(y, 170), 400)
      recipeHeaderHeight.constant = height
   }
}


#if DEBUG
extension DetailVC: UIViewControllerRepresentable {
   func makeUIViewController(context: Context) -> DetailVC {
      let vc = DetailVC()
      return vc
   }
   func updateUIViewController(_ uiViewController: DetailVC, context: Context) {
   }
}

struct DetailVCPreviews: PreviewProvider {
   static var previews: some View {
      DetailVC()
   }
}
#endif



