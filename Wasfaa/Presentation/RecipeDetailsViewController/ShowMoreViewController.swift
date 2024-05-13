//
//  IngredientsViewController.swift
//  Wasfaa
//
//  Created by Salma on 10/05/2024.
//

import UIKit

class ShowMoreViewController: UIViewController {
  //MARK: -IBOutlets
  @IBOutlet weak var moreLabel: UILabel!
  @IBOutlet weak var vieww: UIView!
  
  var id: Int?
  var tag: Int?
  var viewModel = RecipeDetailsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    vieww.layer.cornerRadius = 15
    viewModel.recipeID  = id 
    viewModel.retrieveRecipeDetails(id: id ?? 0)
    viewModel.bindRecipeDetailsToController = {
      DispatchQueue.main.async{
        self.viewModel.recipeDetailsArray = self.viewModel.retrievedDetails
        
        if let ingredients =  self.viewModel.recipeDetailsArray?.extendedIngredients {
          for ingredient in ingredients {
            self.viewModel.recipeIngredients.append("• " + (ingredient.original ?? ""))
            self.viewModel.recipeIngredients.append("\n")
          }
        }
        for step in self.viewModel.recipeDetailsArray?.analyzedInstructions?[0].steps ?? [] {
          self.viewModel.randomRecipeSteps.append("• " + (step.step ?? "" ))
          self.viewModel.randomRecipeSteps.append("\n")
        }
        if self.tag == 1{
          self.moreLabel.text = self.viewModel.recipeIngredients
        }else{
          self.moreLabel.text = self.viewModel.randomRecipeSteps
        }
        
      }
    }
  }
}

//MARK: -IBActions
private extension ShowMoreViewController{
  @IBAction func dismissView(_ sender: UIButton) {
    self.dismiss(animated: true)
  }
  
}
