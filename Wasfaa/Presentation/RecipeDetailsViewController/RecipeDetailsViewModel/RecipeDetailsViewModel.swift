//
//  RecipeDetailsModel.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//

import Foundation
class RecipeDetailsViewModel {
  let recipeDetailsRepo = RecipeDetailsRepository()
  var recipeID: Int?
  var recipeDetailsArray: RecipeDetails?
  var recipeNutrientsArray: Nutrients?
  
  var recipeIngredients: String = ""
  var randomRecipeIngredients: String = ""
  var recipeSteps: String = ""
  var randomRecipeSteps: String = ""
  
  var bindRecipeDetailsToController: (()->()) = {}
  
  var retrievedDetails: RecipeDetails? {
    didSet{
      bindRecipeDetailsToController()
    }
  }
  func ingredientsCount()-> Int {
    return recipeDetailsArray?.extendedIngredients?.count ?? 0
  }
  
  func retrieveRecipeDetails(id: Int){
    recipeDetailsRepo.getDetails(id: recipeID ?? 0) { (result: Result<RecipeDetails, NetworkError>) in
      switch result{
      case .success(let details):
        self.retrievedDetails = details
      case .failure(let error):
        print("Error:\(error)")
      }
    }
  }
  
  var bindRecipeNutrientsToController: (()->()) = {}
  
  var retrievedNutrients: Nutrients? {
    didSet{
      bindRecipeNutrientsToController()
    }
  }
  
  func retrieveRecipeNutrients(id: Int){
    recipeDetailsRepo.getNutrients(id: id) { (result: Result<Nutrients, NetworkError>) in
      switch result{
      case .success(let nutrients):
        self.retrievedNutrients = nutrients
      case .failure(let error):
        print("Error\(error)")
      }
    }
  }
  
}
