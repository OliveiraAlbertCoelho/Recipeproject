//
//  DetailVC.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit
import SwiftUI
import Lottie

final class DetailVC: UIViewController {
   //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      setUpViewDesign()
      setUpConstraints()
      fetchRecipeInfo()
      
   }
   //MARK: - Variables
   var recipeInfo: RecipeInfo?{
      didSet{
         recipeInfoTableView.reloadData()
         setUpRecipeView()
      }
   }
   
   var check = false
   
   
   
   @objc func favoritePressed(){
      if check{
         check = false
         lottieView.play(fromProgress: lottieView.currentProgress, toProgress: 0, loopMode: nil, completion: nil)
         
      }else {
         check = true
         lottieView.play()
         
      }
   }
   var isExpanded = false
   let recipeId = "324694"
   var recipe: RecipeWrapper?
   var headerHeight: CGFloat = 35
   //MARK: - UI Objects
   lazy var swipeRight: UISwipeGestureRecognizer = {
      let swipe = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
      swipe.direction = UISwipeGestureRecognizer.Direction.right
      return swipe
   }()
   lazy var lottieView: AnimationView = {
      let lottieview = AnimationView()
      lottieview.animation = Animation.named("heartAction")
      lottieview.animationSpeed = 2
      lottieview.backgroundColor = .yellow
      return lottieview
   }()
   lazy var favoriteButton: UIButton = {
      let button = UIButton()
      button.addTarget(self, action: #selector(favoritePressed), for: .touchUpInside)
      button.clipsToBounds = true
      return button
   }()
   
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
   
   lazy var recipeInfoTableView: UITableView = {
      let layout = UITableView(frame: .zero, style: .grouped)
      layout.register(NutritionInfoCell.self, forCellReuseIdentifier: "nutritionCell")
      layout.register(RecipeIngredientsCell.self, forCellReuseIdentifier: "ingredientcell")
      layout.register(InstructionsTableViewCell.self, forCellReuseIdentifier: "instructionCell")
      
      layout.separatorStyle = UITableViewCell.SeparatorStyle.none
      layout.backgroundColor = #colorLiteral(red: 0.9489366412, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
      layout.delegate = self
      layout.dataSource = self
      return layout
   }()
   lazy var topHeaderView: UIView = {
      let header = UIView()
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
      let image = UIImage(named: "leftArrow")
      button.tintColor = .black
      button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
      button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
      button.layer.shadowOffset = CGSize(width: 0, height: 3)
      button.layer.shadowOpacity = 1.0
      button.layer.shadowRadius = 10.0
      button.layer.masksToBounds = false
      button.backgroundColor = .red
      let tintedImage = image?.withRenderingMode(.alwaysTemplate)
      button.setImage(tintedImage, for: .normal)
      button.tintColor = .white
      return button
   }()
   lazy var recipeHeaderHeight: NSLayoutConstraint = {
      self.topHeaderView.heightAnchor.constraint(equalToConstant: 310)
   }()
   
   //MARK: - Regular Functions
   
   @objc private func expandSection() {
      isExpanded = !isExpanded
      isExpanded ?  recipeInfoTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade) : recipeInfoTableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
   }
   private func setUpRecipeView(){
      recipeName.text = recipeInfo?.title ?? "not found"
      prepTimeLabel.text = "Prep Time: \(recipeInfo?.readyInMinutes.description ?? "")"
      servingsLabel.text = "Servings: \(recipeInfo?.servings.description ?? "")"
   }
   private func fetchRecipeInfo(){
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
      self.navigationController?.navigationBar.isHidden = true
      recipeInfoTableView.estimatedRowHeight = 80
      recipeInfoTableView.contentInset = UIEdgeInsets(top: 310, left: 0, bottom: 0, right: 0)
      view.backgroundColor = #colorLiteral(red: 0.9489366412, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
      view.addGestureRecognizer(swipeRight)
   }
   private func setUpConstraints(){
      constrainTableView()
      constrainTopHeaderView()
      constrainBottomHeaderView()
      constrainPrepLabel()
      constrainServingSizeLabel()
      constrainBottomLine()
      constrainRecipeName()
      constrainRecipeImage()
      constrainBackButton()
      constrainLottieView()
      constrainButtonFavorite()
   }
   
   //MARK: - Objc functions
   @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
      let transition = CATransition()
      transition.duration = 0.3
      transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
      transition.type = CATransitionType.push
      transition.subtype = CATransitionSubtype.fromLeft
      view.window!.layer.add(transition, forKey: nil)
      navigationController?.popViewController(animated: false)
   }
   @objc private func goBackAction(){
      self.navigationController?.popViewController(animated: true)
   }
}
//MARK: - UITableViewDelegates
extension DetailVC: UITableViewDelegate, UITableViewDataSource{
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      switch section{
      case 0:
         return isExpanded ? 1 : 0
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
         view.expandableSectionButton.addTarget(self, action: #selector(expandSection), for: .touchUpInside)
         view.expandableSectionButton.isHidden = false
      case 1:
         view.headerTitle.text = "Ingredients"
      default:
         view.headerTitle.text = "Preparation"
      }
      return view
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      switch indexPath.section{
      case 0:
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "nutritionCell", for: indexPath) as? NutritionInfoCell else { return UITableViewCell() }
         if let recipeinf = recipeInfo{
            cell.nutritionInfo = recipeinf.nutrition.nutrients
         }
         return cell
         
      case 1:
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientcell", for: indexPath) as? RecipeIngredientsCell else {return UITableViewCell()}
         let data = recipeInfo?.extendedIngredients[indexPath.row]
         cell.ingredientTitleLabel.text = data?.ingredientAmount
         return cell
      default:
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "instructionCell", for: indexPath) as? InstructionsTableViewCell else {return UITableViewCell()}
         let data = recipeInfo?.analyzedInstructions.first?.steps[indexPath.row]
         cell.stepNumber.text = data?.number.description
         cell.stepTitle.text = data?.step
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
         
         return UITableView.automaticDimension
      default:
         return 0
      }
   }
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let y = 300 - (scrollView.contentOffset.y + 300)
      let height = min(max(y, 170), 400)
      recipeHeaderHeight.constant = height
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



