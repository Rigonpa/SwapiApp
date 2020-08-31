//
//  ListInteractor.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 31/08/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

final class ListInteractor {
    weak var presenter: ListInteractorOutput?
}

extension ListInteractor: ListInteractorBasis {
    func loadCharacters() {
        guard let url = URL(string: "https://swapi.dev/api/people") else { return }
        URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            guard let data = data, error == nil else {
                self?.presenter?.charactersRequestFailed(message: "Error on api request")
                return
            }
            let response = try? JSONDecoder().decode(SwapiResponse.self, from: data)
            guard let charactersList = response?.results else {
                self?.presenter?.charactersRequestFailed(message: "Error on response parse process")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.charactersDownloaded(charactersList: charactersList)
            }
        }.resume()
    }
}
