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
  var filteredRecipes: [RandomRecipe]?
  var typee: String = ""
  
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
  
  func recipesFilter(type: filterType, flag: Bool, completion: ()-> Void) {
    // if searchTextField.text == "" {
    filteredRecipes = []
    for recipe in randomRecipesArray?.recipes ?? [] {
      //   print("recipee:\(recipe)")
      switch type {
      case .vegetarian:
        if recipe.vegetarian == true && recipe.vegan == false && recipe.glutenFree == false && recipe.dairyFree == false && recipe.veryHealthy == false {
          filteredRecipes?.append(recipe)
          typee = "Vegetarian"
        }
      case .vegan:
        if recipe.vegan == true && recipe.vegetarian == false && recipe.glutenFree == false && recipe.dairyFree == false && recipe.veryHealthy == false {
          filteredRecipes?.append(recipe)
          typee = "Vegan"
        }
      case .glutenFree:
        if recipe.glutenFree == true && recipe.vegetarian == false && recipe.vegan == false && recipe.dairyFree == false && recipe.veryHealthy == false {
          filteredRecipes?.append(recipe)
          typee = "Gluten"
        }
      case .dairyFree:
        if recipe.dairyFree == true && recipe.vegetarian == false && recipe.vegan == false && recipe.glutenFree == false && recipe.veryHealthy == false {
          filteredRecipes?.append(recipe)
          typee = "Dairy"
        }
      case .veryHealthy:
        if recipe.veryHealthy == true && recipe.vegetarian == false && recipe.vegan == false && recipe.glutenFree == false && recipe.dairyFree == false {
          filteredRecipes?.append(recipe)
          typee = "Healthy"
        }
      }
    }
    completion()
  }
}
enum filterType: String{
  case vegetarian
  case vegan
  case glutenFree
  case dairyFree
  case veryHealthy
}
