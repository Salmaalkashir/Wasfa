//
//  RecipeModel.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//
import Foundation
struct Recipes: Codable{
  var results: [Recipe]
}
struct Recipe: Codable{
  let id: Int?
  let title, image: String?
  let vegetarian, vegan, glutenFree, dairyFree, veryHealthy: Bool?
}
