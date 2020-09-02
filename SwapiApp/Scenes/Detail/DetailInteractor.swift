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
    var networkManager: NetworkManagerProtocol?
}

extension DetailInteractor: DetailInteractorBasis {
    func downloadCharacterData(withIdentifier identifier: String) {
        networkManager?.loadCharacter(characterId: identifier, completion: {[weak self] result in
            switch result {
            case .failure(let error):
                self?.presenter?.failedCharacterRequest(message: error.message)
            case .success(let characterData):
                self?.presenter?.downloadedCharacterData(characterData: characterData)
            }
        })
    }
}
