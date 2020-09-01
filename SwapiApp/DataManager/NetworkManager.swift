//
//  NetworkManager.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 01/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

struct MyError: Error {
    let message: String
}

class NetworkManager {
    
}

extension NetworkManager: NetworkManagerProtocol {
    func loadCharacters(completion: @escaping (Result<[CharacterData], MyError>) -> Void) {
        
        guard let url = URL(string: "https://swapi.dev/api/people") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(MyError(message: "Error on api request")))
                return
            }
            let response = try? JSONDecoder().decode(SwapiResponse.self, from: data)
            guard let charactersList = response?.results else {
                completion(.failure(MyError(message: "Error on response parce process")))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(charactersList))
            }
        }.resume()
    }
}
