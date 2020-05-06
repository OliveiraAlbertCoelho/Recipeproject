//
//  DiscoverVC.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 5/6/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class DiscoverVC: UIViewController {
      //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      setUpView()
   }
   //MARK: - Variables
   var discoverTypes = 
   //MARK: - UI Objects
   //MARK: - Objc Functions
   lazy var browseTableView: UITableView = {
      let layout = UITableView(frame: .zero, style: .plain)
      layout.register(RecipesTableViewCell.self, forCellReuseIdentifier: "recipes")
      layout.delegate = self
      layout.dataSource = self
      return layout
   }()
   //MARK: - Regular Functions
   private func setUpView(){
      view.backgroundColor = .white
      constrainBrowseTableView()
   }
   //MARK: - Constraints
   private func constrainBrowseTableView(){
      view.addSubview(browseTableView)
      browseTableView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         browseTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
         browseTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
         browseTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         browseTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      
      ])
   }

}
extension DiscoverVC: UITableViewDelegate, UITableViewDataSource{
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
      
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipes") as? RecipesTableViewCell else {return UITableViewCell()}
      cell.types = ["a", "b", "c", "d"]
      return cell
   }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 200
   }
   func numberOfSections(in tableView: UITableView) -> Int {
      return discoverTypes.count
   }
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return discoverTypes[section]
   }
}
