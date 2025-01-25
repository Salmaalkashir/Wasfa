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
  @IBOutlet weak var ingredientss: UITextView!
  @IBOutlet weak var howToMake: UITextView!
  @IBOutlet weak var ingredientsStepsSegmentControl: UISegmentedControl!
  
  let recipeDetailsViewModel = RecipeDetailsViewModel()
  var randomDetails: RandomRecipe?
  var recipeDetailsID: Recipe?
  var fromWhere: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    recipeDetailsViewModel.recipeID = recipeDetailsID?.id
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
      if let ingredients = randomDetails?.extendedIngredients {
        let attributedText = NSMutableAttributedString()
        
        let font = UIFont.systemFont(ofSize: 14)
        
        for ingredient in ingredients {
          let redDot = NSAttributedString(
            string: "●   ",
            attributes: [
              NSAttributedString.Key.foregroundColor: UIColor(named: "mainColor"),
              NSAttributedString.Key.font: font
            ]
          )
          attributedText.append(redDot)
          let ingredientText = NSAttributedString(
            string: (ingredient.original ?? "") + "\n",
            attributes: [
              NSAttributedString.Key.foregroundColor: UIColor.black,
              NSAttributedString.Key.font: font
            ]
          )
          let newline = NSAttributedString(string: "\n")
          
          attributedText.append(ingredientText)
          attributedText.append(newline)
        }
        ingredientss.attributedText = attributedText
      }


      let attributedText = NSMutableAttributedString()
      let font = UIFont.systemFont(ofSize: 14)

      for step in randomDetails?.analyzedInstructions?[0].steps ?? [] {
          let redDot = NSAttributedString(
              string: "●   ",
              attributes: [
                  NSAttributedString.Key.foregroundColor: UIColor(named: "mainColor"),
                  NSAttributedString.Key.font: font
              ]
          )
          attributedText.append(redDot)
          let stepText = NSAttributedString(
              string: (step.step ?? ""),
              attributes: [
                  NSAttributedString.Key.foregroundColor: UIColor.black,
                  NSAttributedString.Key.font: font
              ]
          )
          attributedText.append(stepText)
          let newline = NSAttributedString(string: "\n")
          attributedText.append(newline)
        attributedText.append(newline)
      }
      howToMake.attributedText = attributedText

    }else{
      recipeDetailsViewModel.retrieveRecipeDetails(id: recipeDetailsID?.id ?? 0)
      recipeDetailsViewModel.bindRecipeDetailsToController = {
        DispatchQueue.main.async {
          self.recipeDetailsViewModel.recipeDetailsArray = self.recipeDetailsViewModel.retrievedDetails
          self.recipeImage.sd_setImage(with: URL(string: self.recipeDetailsViewModel.recipeDetailsArray?.image ?? ""),placeholderImage: UIImage(named: "noImage"))
          self.recipeName.text = self.recipeDetailsViewModel.recipeDetailsArray?.title
          self.servingsNumber.text = String(self.recipeDetailsViewModel.recipeDetailsArray?.servings ?? 0)
          self.minsNumber.text = String(self.recipeDetailsViewModel.recipeDetailsArray?.readyInMinutes ?? 0)
          self.recipeDetailsViewModel.retrieveRecipeNutrients(id: self.recipeDetailsID?.id ?? 0)
          self.recipeDetailsViewModel.bindRecipeNutrientsToController = {
            DispatchQueue.main.async {
              self.recipeDetailsViewModel.recipeNutrientsArray = self.recipeDetailsViewModel.retrievedNutrients
              self.calNumber.text = self.recipeDetailsViewModel.recipeNutrientsArray?.calories ?? ""
            }
          }
          let ingredientsAttributedText = NSMutableAttributedString()
          let stepsAttributedText = NSMutableAttributedString()
          let font = UIFont.systemFont(ofSize: 14)
          
          if let ingredients = self.recipeDetailsViewModel.recipeDetailsArray?.extendedIngredients {
            for ingredient in ingredients {
              let redDot = NSAttributedString(
                string: "●   ",
                attributes: [
                  NSAttributedString.Key.foregroundColor: UIColor(named: "mainColor"),
                  NSAttributedString.Key.font: font
                ]
              )
              ingredientsAttributedText.append(redDot)
              let ingredientText = NSAttributedString(
                string: (ingredient.original ?? ""),
                attributes: [
                  NSAttributedString.Key.foregroundColor: UIColor.black,
                  NSAttributedString.Key.font: font
                ]
              )
              ingredientsAttributedText.append(ingredientText)
              let newline = NSAttributedString(string: "\n")
              ingredientsAttributedText.append(newline)
            }
          }
          self.ingredientss.attributedText = ingredientsAttributedText
          
          if let steps = self.recipeDetailsViewModel.recipeDetailsArray?.analyzedInstructions?[0].steps {
            for step in steps {
              let redDot = NSAttributedString(
                string: "●   ",
                attributes: [
                  NSAttributedString.Key.foregroundColor: UIColor(named: "mainColor"),
                  NSAttributedString.Key.font: font
                ]
              )
              stepsAttributedText.append(redDot)
              let stepText = NSAttributedString(
                string: (step.step ?? ""),
                attributes: [
                  NSAttributedString.Key.foregroundColor: UIColor.black,
                  NSAttributedString.Key.font: font
                ]
              )
              stepsAttributedText.append(stepText)
              let newline = NSAttributedString(string: "\n")
              stepsAttributedText.append(newline)
              stepsAttributedText.append(newline)
            }
          }
          self.howToMake.attributedText = stepsAttributedText
        }
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = true
  }
  
  
  func configureViews(){
    howToMake.isHidden = true
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
    
    ingredientsStepsSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    ingredientsStepsSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
  }
}
//MARK: -IBActions
private extension RecipeDetailsViewController {
  @IBAction func goBack(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
    switch ingredientsStepsSegmentControl.selectedSegmentIndex {
    case 0:
      howToMake.isHidden = true
      ingredientss.isHidden = false
    case 1:
      howToMake.isHidden = false
      ingredientss.isHidden = true
    default:
      break
    }
  }
}
