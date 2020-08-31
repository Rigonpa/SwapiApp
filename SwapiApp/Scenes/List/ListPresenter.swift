//
//  ListPresenter.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 31/08/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

final class ListPresenter {
    var router: ListRouterBasis?
    weak var view: ListViewBasis?
    var interactor: ListInteractorBasis?
}

extension ListPresenter: ListPresenterBasis {
    func viewIsReady() {
        interactor?.loadCharacters()
    }
    
    func characterIsSelected(withIdentifier identifier: String) {
        router?.characterIsSelected(withIdentifier: identifier)
    }
}

extension ListPresenter: ListInteractorOutput {
    func charactersRequestFailed(message: String) {
        view?.failedCharactersRequest(message: message)
    }
    
    func charactersDownloaded(charactersList: [CharacterData]) {
        let charactersViewInfo = charactersList.map { CharacterViewInfo(id: $0.identifier, name: $0.name, height: $0.height)}
        view?.onShowCharactersList(charactersViewInfo: charactersViewInfo)
    }
}
