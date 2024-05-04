//
//  RandomRecipesModel.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//

import Foundation
struct RandomRecipes: Codable {
  let recipes: [RandomRecipe]?
}
struct RandomRecipe: Codable{
  let vegetarian, vegan, glutenFree, dairyFree, veryHealthy: Bool?
  let title, image, instructions: String?
  let id, readyInMinutes, servings: Int?
  let analyzedInstructions: [RandomAnalyzedInstruction]?
  let extendedIngredients: [RandomExtendedIngredient]?
}
struct RandomExtendedIngredient: Codable {
  let unit, original, image, name: String?
  let amount: Double?
  let consistency: RConsistency
}
enum RConsistency: String, Codable {
  case liquid = "LIQUID"
  case solid = "SOLID"
}
struct RandomAnalyzedInstruction: Codable {
  let name: String?
  let steps: [RandomStep]?
}

struct RandomStep: Codable {
  let number: Int?
  let step: String?
  let ingredients, equipment: [RandomEnt]?
  let length: RandomLength?
}
struct RandomEnt: Codable {
  let id: Int?
  let name, localizedName: String?
  let image: String?
  let temperature: RandomLength?
}
struct RandomLength: Codable {
  let number: Int?
  let unit: String?
}
struct RandomNutrients: Codable {
    let calories, carbs, fat, protein: String?
}
