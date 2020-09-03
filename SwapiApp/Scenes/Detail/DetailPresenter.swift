//
//  DetailPresenter.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 01/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

final class DetailPresenter {
    var router: DetailRouterBasis?
    weak var view: DetailViewBasis?
    var interactor: DetailInteractorBasis?
    
    var characterId: String?
}

extension DetailPresenter: DetailPresenterBasis {
    func viewIsReady() {
        guard let characterId = characterId else {
            router?.popViewController()
            return
        }
        interactor?.downloadCharacterData(withIdentifier: characterId)
    }
}

extension DetailPresenter: DetailInteractorOutput {
    func downloadedCharacterData(characterData: CharacterData) {
        view?.onShowingCharacterData(characterData: characterData)
    }
    
    func failedCharacterRequest(message: String) {
        router?.popViewController()
    }
}
