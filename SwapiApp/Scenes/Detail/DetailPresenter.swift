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
}

extension DetailPresenter: DetailPresenterBasis {
    func viewIsReady(characterId: String) {
        interactor?.downloadCharacterData(withIdentifier: characterId)
    }
}

extension DetailPresenter: DetailInteractorOutput {
    func downloadedCharacterData(characterData: CharacterData) {
        <#code#>
    }
    
    func failedCharacterRequest(message: String) {
        view?.onShowingRequestError(message: message)
    }
}
