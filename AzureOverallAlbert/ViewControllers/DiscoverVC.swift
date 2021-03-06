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
      navigationItem.title = "Discover"
   }
   //MARK: - Variables
   var discoverTypes = DiscoverModel()
   //MARK: - UI Objects
   //MARK: - Objc Functions
   lazy var browseTableView: UITableView = {
      let layout = UITableView(frame: .zero, style: .grouped)
      layout.register(RecipesTableViewCell.self, forCellReuseIdentifier: "recipes")
      layout.delegate = self
      layout.dataSource = self
      return layout
   }()
   lazy var discoverSearchBar: UISearchBar = {
      let searchBar = UISearchBar()
      return searchBar
   }()
   
   //MARK: - Regular Functions
   private func setUpView(){
      view.backgroundColor = .white
      constrainDiscoverSearchBar()
      constrainBrowseTableView()
   }
   //MARK: - Constraints
   private func constrainBrowseTableView(){
      view.addSubview(browseTableView)
      browseTableView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         browseTableView.topAnchor.constraint(equalTo: discoverSearchBar.bottomAnchor, constant: 0),
         browseTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
         browseTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         browseTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
         
      ])
   }
   private func constrainDiscoverSearchBar(){
      view.addSubview(discoverSearchBar)
      discoverSearchBar.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         discoverSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
         discoverSearchBar.heightAnchor.constraint(equalToConstant: 50),
         discoverSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         discoverSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
         
      ])
   }
   
}
extension DiscoverVC: UITableViewDelegate, UITableViewDataSource{
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
      return 1
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipes") as? RecipesTableViewCell else {return UITableViewCell()}
      let data = discoverTypes.discoverTypes[indexPath.section]
      cell.discoverData = data
      cell.delegate = self
      cell.searchStringType = indexPath.section
      return cell
   }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 200
   }
   func numberOfSections(in tableView: UITableView) -> Int {
      return discoverTypes.discoverTypes.count
   }
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return discoverTypes.titles[section]
   }

   func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
      if let headerView = view as? UITableViewHeaderFooterView {
                headerView.textLabel?.textColor = .orange
         headerView.textLabel?.font = .boldSystemFont(ofSize: 20)
         headerView.contentView.backgroundColor = .white
            }
      }
   }

extension DiscoverVC: DiscoverTypeProtocol{
   func pressAction(row: Int, section: Int) {
      let browseVc = BrowseVC()
      switch section {
      case 0:
         browseVc.recipeFetchType = .cuisine
      case 1:
         browseVc.recipeFetchType = .diet
      default:
         browseVc.recipeFetchType = .query
      }
      browseVc.searchStr = discoverTypes.discoverTypes[section][row]
      navigationController?.pushViewController(browseVc, animated: true)
   }
}


