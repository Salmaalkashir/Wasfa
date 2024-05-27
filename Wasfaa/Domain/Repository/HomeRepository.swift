//
//  HomeRepository.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//

import Foundation
//MARK: - HomeRepositoryProtocol
protocol HomeRepositoryProtocol {
  func getRandomRecipes( completion: @escaping (Result<RandomRecipes, NetworkError>)-> Void)
  func getRecipes(query: String, completion: @escaping (Result<Recipes, NetworkError>)-> Void)
  func getGluten(intolerance: EndPoints,completion: @escaping (Result<Recipes, NetworkError>)-> Void)
}

//MARK: - HomeRepository
class HomeRepository: HomeRepositoryProtocol {
  let networkService: NetworkServiceProtocol = NetworkService()
  func getRandomRecipes(completion: @escaping (Result<RandomRecipes, NetworkError>) -> Void) {
    networkService.getData(endpoint: .randomRecipes,completion: completion)
  }
  
  func getRecipes(query: String, completion: @escaping (Result<Recipes, NetworkError>) -> Void) {
    networkService.getData(endpoint: .ingredientSearch(ingredient: query),completion: completion)
  }
  
  func getGluten(intolerance: EndPoints,completion: @escaping (Result<Recipes, NetworkError>)-> Void ) {
    networkService.getData(endpoint: intolerance, completion: completion)
  }
}
