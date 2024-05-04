//
//  NetworkService.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//

import Foundation
protocol NetworkServiceProtocol{
  func getData<Data:Decodable>(endpoint: EndPoints, completion: @escaping (Result<Data,NetworkError>)-> Void)
}

class NetworkService: NetworkServiceProtocol {
  
  func createURL(path: EndPoints)-> URL?{
    let baseUrl = "https://api.spoonacular.com/recipes"
    let urlString = baseUrl + path.stringValue
    return URL(string: urlString)
  }
  func getData<Data>(endpoint: EndPoints, completion: @escaping (Result<Data, NetworkError>) -> Void) where Data : Decodable {
    guard let url = createURL(path: endpoint) else{
      completion(.failure(.invalidURL))
      return
    }
    
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else{
        completion(.failure(.invalidResponse))
        return
      }
      
      do{
        let decodedObject = try JSONDecoder().decode(Data.self, from: data)
        print("T Type:\(Data.self)")
        completion(.success(decodedObject))
      }catch{
        print(error.localizedDescription)
        completion(.failure(.decodingFailed(error)))
      }
      
    }
    task.resume()
    
  }
}
