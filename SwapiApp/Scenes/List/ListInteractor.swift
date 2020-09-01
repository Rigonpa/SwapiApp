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
    var networkManager: NetworkManagerProtocol?
}

extension ListInteractor: ListInteractorBasis {
    func loadCharacters() {
        networkManager?.loadCharacters {[weak self] result in
            switch result {
            case .failure(let error):
                self?.presenter?.charactersRequestFailed(message: error.message)
            case .success(let charactersData):
                self?.presenter?.charactersDownloaded(charactersList: charactersData)
            }
        }
    }
}
