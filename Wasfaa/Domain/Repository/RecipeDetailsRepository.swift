//
//  RecipeDetailsRepository.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//

import Foundation
//MARK: -RecipeDetailsRepositoryProtocol
protocol RecipeDetailsRepositoryProtocol {
  func getDetails(id: Int, completion: @escaping (Result<RecipeDetails,NetworkError>)-> Void)
  func getNutrients(id: Int, completion: @escaping (Result<Nutrients,NetworkError>)-> Void)
}
//MARK: -RecipeDetailsRepository
class RecipeDetailsRepository: RecipeDetailsRepositoryProtocol {
  let networkService: NetworkServiceProtocol = NetworkService()
  func getDetails(id: Int, completion: @escaping (Result<RecipeDetails, NetworkError>) -> Void) {
    networkService.getData(endpoint: .recipeDetails(id: id), completion: completion)
  }
  func getNutrients(id: Int, completion: @escaping (Result<Nutrients,NetworkError>)-> Void) {
    networkService.getData(endpoint: .nutritionWidget(id: id), completion: completion)
  }
}
