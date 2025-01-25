//
//  HomeViewController.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//

import UIKit

class HomeViewController: UIViewController {
  //MARK: -IBoutlets
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var recipesCollectionView: UICollectionView!
  @IBOutlet weak var intoleranceSegmentControl: UISegmentedControl!
  @IBOutlet weak var noRecipes: UIView!
  @IBOutlet weak var filterButton: UIButton!
  
  let homeViewModel = HomeViewModel()
  let recipevm = RecipeDetailsViewModel()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureTextField()
    filteer()
    filterButton.layer.cornerRadius = 20
    noRecipes.isHidden = true
    homeViewModel.retrievedRandomRecipe()
    homeViewModel.bindRandomRecipesToController = {
      DispatchQueue.main.async {
        self.homeViewModel.randomRecipesArray = self.homeViewModel.retrievedRandomRecipes
        self.recipesCollectionView.reloadData()
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.tintColor = UIColor.white
  }
  
  func configureCollectionView() {
    recipesCollectionView.dataSource = self
    recipesCollectionView.delegate = self
    let nib = UINib(nibName: "RecipesCollectionViewCell", bundle: nil)
    recipesCollectionView.register(nib, forCellWithReuseIdentifier: "recipesCell")
    recipesCollectionView.layer.cornerRadius = 20
  }
  func filteer(){
    _ = {(action : UIAction) in
    }
    self.filterButton.menu = UIMenu(title : "" ,children: [
      UIAction(title: "Vegetarian",subtitle: "", handler: { (_) in
        self.homeViewModel.recipesFilter(type: .vegetarian, flag: self.searchTextField.text == "") { [weak self] in self?.recipesCollectionView.reloadData()
        }}),
      UIAction(title: "Vegan",subtitle: "", handler: { _ in
        self.homeViewModel.recipesFilter(type: .vegan, flag: self.searchTextField.text == "") {
          [weak self] in self?.recipesCollectionView.reloadData()
        }}),
      UIAction(title: "Gluten Free",subtitle: "", handler: { (_) in
        self.homeViewModel.recipesFilter(type: .glutenFree, flag: self.searchTextField.text == "") {
          [weak self] in self?.recipesCollectionView.reloadData()
        }}),
      UIAction(title: "Dairy Free",
               subtitle: "",
               handler: { (_) in
                 self.homeViewModel.recipesFilter(type: .dairyFree, flag: self.searchTextField.text == "") { [weak self] in
           self?.recipesCollectionView.reloadData()
        }}),
      UIAction(title: "Healthy",subtitle: "", handler: { (_) in
        self.homeViewModel.recipesFilter(type: .veryHealthy, flag: self.searchTextField.text == "") {
          [weak self] in self?.recipesCollectionView.reloadData()
        }})
    ])
    filterButton.showsMenuAsPrimaryAction = true
  }
}
//MARK: -UICollectionViewDelegate,UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if searchTextField.text == "" && (homeViewModel.typee == "Vegetarian" || homeViewModel.typee == "Vegan" || homeViewModel.typee == "Gluten" || homeViewModel.typee == "Dairy" || homeViewModel.typee == "Healthy"){
      return homeViewModel.filteredRecipes?.count ?? 0
      
    }else if searchTextField.text == "" {
      return homeViewModel.randomRecipeCount()
    }
    else{
      return homeViewModel.recipeCount()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipesCell", for: indexPath) as! RecipesCollectionViewCell
    if searchTextField.text == "" && (homeViewModel.typee == "Vegetarian" || homeViewModel.typee == "Vegan" || homeViewModel.typee == "Gluten" || homeViewModel.typee == "Dairy" || homeViewModel.typee == "Healthy"){
      cell.configureCell(image: homeViewModel.filteredRecipes?[indexPath.row].image ?? "", name: homeViewModel.filteredRecipes?[indexPath.row].title ?? "")
      return cell
    }else if searchTextField.text == "" {
      cell.configureCell(image: homeViewModel.randomRecipesArray?.recipes?[indexPath.row].image ?? "", name: homeViewModel.randomRecipesArray?.recipes?[indexPath.row].title ?? "")
      return cell
    }else{
      cell.configureCell(image: homeViewModel.recipesArray?.results[indexPath.row].image ?? "", name: homeViewModel.recipesArray?.results[indexPath.row].title ?? "")
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let recipeDetailsObj = RecipeDetailsViewController()
    if searchTextField.text == "" && (homeViewModel.typee == "Vegetarian" || homeViewModel.typee == "Vegan" || homeViewModel.typee == "Gluten" || homeViewModel.typee == "Dairy" || homeViewModel.typee == "Healthy"){
      recipeDetailsObj.fromWhere = "Filtered"
      recipeDetailsObj.randomDetails = homeViewModel.filteredRecipes?[indexPath.row]
      self.navigationController?.pushViewController(recipeDetailsObj, animated: true)
    }else  if searchTextField.text == ""{
      recipeDetailsObj.randomDetails = homeViewModel.randomRecipesArray?.recipes?[indexPath.row]
      recipeDetailsObj.fromWhere = "Random"
      print("NAME:\(homeViewModel.randomRecipesArray?.recipes?[indexPath.row].title)")
      print("STEPS:\(homeViewModel.randomRecipesArray?.recipes?[indexPath.row].analyzedInstructions)")
      self.navigationController?.pushViewController(recipeDetailsObj, animated: true)
    }else{
      recipeDetailsObj.recipeDetailsID = homeViewModel.recipesArray?.results[indexPath.row]
     // print("STEPS:\(homeViewModel.recipesArray?.results[indexPath.row])")
      self.navigationController?.pushViewController(recipeDetailsObj, animated: true)
    }
  }
}

//MARK: -UICollectionViewDelegateFlowLayout
extension HomeViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let collectionViewWidth = collectionView.frame.size.width
    let cellWidth = (collectionViewWidth / 2) - 20
    let cellHeight = cellWidth * (1.1)
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
}
//MARK: -UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
  func configureTextField(){
    searchTextField.delegate = self
    searchTextField.setLeftView(image: UIImage(systemName: "magnifyingglass")!)
    searchTextField.stylingTextField()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    search()
    return true
  }
  
  func search() {
    homeViewModel.retrieveRecipes(ing: searchTextField.text ?? "")
    homeViewModel.bindRecipesToController = {
      DispatchQueue.main.async {
        self.homeViewModel.recipesArray = self.homeViewModel.retrievedRecipes
        if self.homeViewModel.retrievedRecipes?.results.count == 0{
          self.noRecipes.isHidden = false
        }else{
          self.noRecipes.isHidden = true
        }
        self.recipesCollectionView.reloadData()
      }
    }
  }
}
