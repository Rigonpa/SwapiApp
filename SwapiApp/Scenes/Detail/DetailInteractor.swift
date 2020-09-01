//
//  DetailInteractor.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 01/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

final class DetailInteractor {
    
    weak var presenter: DetailInteractorOutput?
}

extension DetailInteractor: DetailInteractorBasis {
    func downloadCharacterData(withIdentifier identifier: String) {
        guard let url = URL(string: "https://swapi.dev/api/people/\(identifier)") else { return }
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.failedCharacterRequest(message: "Error on fetching character data")
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let characterData = try JSONDecoder().decode(CharacterData.self, from: data)
                    self?.presenter?.downloadedCharacterData(characterData: characterData)
                } catch let error {
                    self?.presenter?.failedCharacterRequest(message: "Error on data parse process: \(error.localizedDescription)")
                    return
                }
            }
        }.resume()
    }
}
