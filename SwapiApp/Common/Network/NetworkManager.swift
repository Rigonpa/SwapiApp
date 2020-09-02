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

protocol NetworkManagerProtocol {
    func loadCharacters(completion: @escaping (Result<[CharacterData], MyError>) -> Void)
    func loadCharacter(characterId: String, completion: @escaping (Result<CharacterData, MyError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    
    var baseURL: URL?
    init(baseURL: URL = URL(string: "https://swapi.dev/api/")!) {
        self.baseURL = baseURL
    }
    
    func loadCharacters(completion: @escaping (Result<[CharacterData], MyError>) -> Void) {
        
        guard let url = baseURL?.appendingPathComponent("people") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(MyError(message: "Error on api request: \(error.localizedDescription)")))
                } else if let data = data {
                    do {
                        let response = try JSONDecoder().decode(SwapiResponse.self, from: data)
                        completion(.success(response.results))
                    } catch let error {
                        completion(.failure(MyError(message: "Error on response parce process: \(error.localizedDescription)")))
                    }
                }
            }
        }
        task.resume()
    }
    
    func loadCharacter(characterId: String, completion: @escaping (Result<CharacterData, MyError>) -> Void) {
        
        guard let url = baseURL?.appendingPathComponent("people").appendingPathComponent(characterId) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                 if let error = error {
                    completion(.failure(MyError(message: "Error on fetching character data: \(error.localizedDescription)")))
                 } else if let data = data {
                    do {
                        let characterData = try JSONDecoder().decode(CharacterData.self, from: data)
                        completion(.success(characterData))
                    } catch let error {
                        completion(.failure(MyError(message: "Error on data parse process: \(error.localizedDescription)")))
                    }
                }
            }
        }
        task.resume()
    }
}
