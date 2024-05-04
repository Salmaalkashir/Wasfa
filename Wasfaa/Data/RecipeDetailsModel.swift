//
//  RecipeDetailsModel.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//

import Foundation
struct RecipeDetails: Codable {
  let vegetarian, vegan, glutenFree, dairyFree, veryHealthy: Bool?
  let extendedIngredients: [ExtendedIngredient]?
  let id, readyInMinutes, servings: Int?
  let title, image, summary, instructions: String?
  let analyzedInstructions: [AnalyzedInstruction]?
  
}
struct ExtendedIngredient: Codable {
  let unit, original, image, name: String?
  let amount: Double?
  let consistency: Consistency
}
enum Consistency: String, Codable {
    case liquid = "LIQUID"
    case solid = "SOLID"
}
struct AnalyzedInstruction: Codable {
  let name: String?
  let steps: [Step]?
}

struct Step: Codable {
  let number: Int?
  let step: String?
  let ingredients, equipment: [Ent]?
  let length: Length?
}
struct Ent: Codable {
  let id: Int?
  let name, localizedName: String?
  let image: String?
  let temperature: Length?
}
struct Length: Codable {
  let number: Int?
  let unit: String?
}
struct Nutrients: Codable {
    let calories, carbs, fat, protein: String?
}
