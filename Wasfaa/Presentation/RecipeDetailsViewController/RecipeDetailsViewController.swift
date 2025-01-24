//
//  RecipeDetailsViewController.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//

import UIKit
import SDWebImage

class RecipeDetailsViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var recipeImage: UIImageView!
  @IBOutlet weak var detailsView: UIView!
  @IBOutlet weak var scrollview: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var readyView: UIView!
  @IBOutlet weak var clockView: UIView!
  @IBOutlet weak var servingsView: UIView!
  @IBOutlet weak var personsView: UIView!
  @IBOutlet weak var recipeName: UILabel!
  @IBOutlet weak var servingsNumber: UILabel!
  @IBOutlet weak var minsNumber: UILabel!
  @IBOutlet weak var caloriesView: UIView!
  @IBOutlet weak var flameView: UIView!
  @IBOutlet weak var calNumber: UILabel!
  @IBOutlet weak var ingredients: UILabel!
  @IBOutlet weak var howToMake: UILabel!
  @IBOutlet weak var showMoreIngredients: UIButton!
  @IBOutlet weak var showMoreHowToMake: UIButton!
  
  let recipeDetailsViewModel = RecipeDetailsViewModel()
  var randomDetails: RandomRecipe?
  var recipeDetailsID: Int?
  var fromWhere: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    showMoreIngredients.isHidden = true
    showMoreHowToMake.isHidden = true
    recipeDetailsViewModel.recipeID = recipeDetailsID
    if fromWhere == "Random" || fromWhere == "Filtered"{
      recipeImage.sd_setImage(with: URL(string: randomDetails?.image ?? ""),placeholderImage: UIImage(named: "noImage"))
      recipeName.text = randomDetails?.title
      servingsNumber.text = String(randomDetails?.servings ?? 0)
      minsNumber.text = String(randomDetails?.readyInMinutes ?? 0)
      recipeDetailsViewModel.retrieveRecipeNutrients(id:randomDetails?.id ?? 0)
      recipeDetailsViewModel.bindRecipeNutrientsToController = {
        DispatchQueue.main.async {
          self.recipeDetailsViewModel.recipeNutrientsArray = self.recipeDetailsViewModel.retrievedNutrients
          self.calNumber.text = self.recipeDetailsViewModel.recipeNutrientsArray?.calories ?? ""
        }
      }
      var letterCount = 0
      
      for _ in randomDetails?.extendedIngredients?[0].original ?? "" {
        letterCount += 1
      }
      
      if let ingredients =  randomDetails?.extendedIngredients {
        var letterCount = 0
        for ingredient in ingredients {
          recipeDetailsViewModel.randomRecipeIngredients.append("• " + (ingredient.original ?? ""))
          recipeDetailsViewModel.randomRecipeIngredients.append("\n")
          for _ in ingredients{
            letterCount += 1
          }
        }
        if letterCount >= 75 {
          showMoreIngredients.isHidden = false
        }
      }
      ingredients.text = recipeDetailsViewModel.randomRecipeIngredients
      if randomDetails?.analyzedInstructions?[0].steps?.count == nil {
        howToMake.text = "No steps for this recipe"
      }else{
        var letterCount = 0
        for step in randomDetails?.analyzedInstructions?[0].steps ?? [] {
          recipeDetailsViewModel.randomRecipeSteps.append("• " + (step.step ?? "" ))
          recipeDetailsViewModel.randomRecipeSteps.append("\n")
          for _ in randomDetails?.analyzedInstructions?[0].steps?[0].step ?? "" {
            letterCount += 1
          }
        }
        if letterCount >= 505 {
          self.showMoreHowToMake.isHidden = false
        }
      }
      howToMake.text = recipeDetailsViewModel.randomRecipeSteps
      
    }else{
      recipeDetailsViewModel.retrieveRecipeDetails(id: recipeDetailsID ?? 0)
      recipeDetailsViewModel.bindRecipeDetailsToController = {
        DispatchQueue.main.async {
          self.recipeDetailsViewModel.recipeDetailsArray = self.recipeDetailsViewModel.retrievedDetails
          self.recipeImage.sd_setImage(with: URL(string: self.recipeDetailsViewModel.recipeDetailsArray?.image ?? ""),placeholderImage: UIImage(named: "noImage"))
          self.recipeName.text = self.recipeDetailsViewModel.recipeDetailsArray?.title
          self.servingsNumber.text = String(self.recipeDetailsViewModel.recipeDetailsArray?.servings ?? 0)
          self.minsNumber.text = String(self.recipeDetailsViewModel.recipeDetailsArray?.readyInMinutes ?? 0)
          self.recipeDetailsViewModel.retrieveRecipeNutrients(id: self.recipeDetailsID ?? 0)
          self.recipeDetailsViewModel.bindRecipeNutrientsToController = {
            DispatchQueue.main.async {
              self.recipeDetailsViewModel.recipeNutrientsArray = self.recipeDetailsViewModel.retrievedNutrients
              self.calNumber.text = self.recipeDetailsViewModel.recipeNutrientsArray?.calories ?? ""
            }
          }
          if let ingredients =  self.recipeDetailsViewModel.recipeDetailsArray?.extendedIngredients {
            var letterCount = 0
            for ingredient in ingredients {
              self.recipeDetailsViewModel.recipeIngredients.append("• " + (ingredient.original ?? ""))
              self.recipeDetailsViewModel.recipeIngredients.append("\n")
              for _ in ingredients{
                letterCount += 1
              }
            }
            if letterCount >= 75 {
              self.showMoreIngredients.isHidden = false
            }
          }
          self.ingredients.text = self.recipeDetailsViewModel.recipeIngredients
          if self.randomDetails?.analyzedInstructions?[0].steps?.count == nil {
            self.howToMake.text = "No steps for this recipe"
          }else{
            for step in self.recipeDetailsViewModel.recipeDetailsArray?.analyzedInstructions?[0].steps ?? [] {
              self.recipeDetailsViewModel.recipeSteps.append("• " + (step.step ?? "" ))
              self.recipeDetailsViewModel.recipeSteps.append("\n")
              self.howToMake.text = self.recipeDetailsViewModel.recipeSteps
            }
          }
        }
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = true
  }
  
  
  func configureViews(){
    detailsView.layer.cornerRadius = 20
    detailsView.layer.shadowOffset = CGSize(width: 5, height: 5)
    detailsView.layer.shadowRadius = 5
    detailsView.layer.shadowOpacity = 0.8
    detailsView.clipsToBounds = true
    detailsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    
    readyView.layer.cornerRadius = 30
    clockView.layer.cornerRadius = 25
    servingsView.layer.cornerRadius = 30
    personsView.layer.cornerRadius = 25
    caloriesView.layer.cornerRadius = 30
    flameView.layer.cornerRadius = 25
  }
}
//MARK: -IBActions
private extension RecipeDetailsViewController {
  @IBAction func goBack(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func showMore(_ sender: UIButton) {
    let more  = ShowMoreViewController()
    if fromWhere == "Random" || fromWhere == "Filtered"{
      more.id = randomDetails?.id
    }else{
      more.id = recipeDetailsID
    }
    more.tag = sender.tag
    more.modalPresentationStyle = .overCurrentContext
    present(more, animated: true, completion: nil)
  }
  
}
