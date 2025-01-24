//
//  Constants.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//

import Foundation
// MARK: - Handling Error
enum NetworkError: Error {
  case invalidURL
  case requestFailed(Error)
  case invalidResponse
  case decodingFailed(Error)
}
let apiKey = "db49041c5e8140b9b729e4889d0d21ad"
//MARK: -EndPoints
enum EndPoints {
  case ingredientSearch(ingredient: String)
  case randomRecipes
  case recipeDetails(id: Int)
  case filter(intolerance: String)
  case nutritionWidget(id: Int)
  var stringValue: String {
    switch self {
    case let .ingredientSearch(ingredient: ingredient):
      return "/complexSearch?query=\(ingredient)&apiKey=\(apiKey)"
    case .randomRecipes:
      return "/random?number=50&apiKey=\(apiKey)"
    case let .recipeDetails(id: id):
      return "/\(id)/information?apiKey=\(apiKey)"
    case let .filter(intolerance: intolerance):
      return "/complexSearch?intolerances=\(intolerance)&apiKey=\(apiKey)"
    case let .nutritionWidget(id: id):
      return "/\(id)/nutritionWidget.json?apiKey=\(apiKey)"
    }
    
  }
}
