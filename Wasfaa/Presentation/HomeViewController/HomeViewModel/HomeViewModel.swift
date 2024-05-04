//
//  HomeViewModel.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//

import Foundation
class HomeViewModel {
  var recipesArray: Recipes?
  var randomRecipesArray: RandomRecipes?
  var intoleranceArray: Recipes?
  let homeRepo = HomeRepository()
  
  func recipeCount()-> Int {
    recipesArray?.results.count ?? 0
  }
  
  var bindRecipesToController: (()->()) = {}
  
  var retrievedRecipes: Recipes? {
    didSet{
      bindRecipesToController()
    }
  }
  
  func retrieveRecipes(ing: String) {
    homeRepo.getRecipes(query: ing) { (result: Result<Recipes, NetworkError>) in
      switch result{
      case .success(let recipe):
        self.retrievedRecipes = recipe
        print("searched:\(recipe)")
      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }
  
  func randomRecipeCount()->Int {
    randomRecipesArray?.recipes?.count ?? 0
    
  }
  
  var bindRandomRecipesToController: (()->()) = {}
  
  var retrievedRandomRecipes: RandomRecipes? {
    didSet{
      bindRandomRecipesToController()
    }
  }
  
  func retrievedRandomRecipe(){
    homeRepo.getRandomRecipes { (result: Result<RandomRecipes, NetworkError>) in
      switch result{
      case .success(let recipe):
        self.retrievedRandomRecipes = recipe
      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }
  
  var bindIntoleranceRecipesToController: (()->()) = {}
  
  var retrievedIntoleranceRecipes: Recipes? {
    didSet{
      bindIntoleranceRecipesToController()
    }
  }
  
  func retrievedIntoleranceRecipe(intolerance: EndPoints){
    homeRepo.getGluten(intolerance: intolerance) { (result: Result<Recipes, NetworkError>) in
      switch result{
      case .success(let intolerance):
        self.retrievedIntoleranceRecipes = intolerance
      case .failure(let error):
        print("Error:\(error)")
      }
    }
  }
}
enum filterType: String{
  case vegetarian
  case vegan
  case glutenFree
  case dairyFree
  case veryHealthy
}
