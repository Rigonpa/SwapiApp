//
//  ListContract.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 31/08/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

protocol ListRouterBasis {
    func characterIsSelected(withIdentifier identifier: String)
}

protocol ListPresenterBasis {
    func viewIsReady()
    func characterIsSelected(withIdentifier identifier: String)
}

protocol ListInteractorBasis {
    func loadCharacters()
}

protocol ListInteractorOutput: class {
    func charactersDownloaded(charactersList: [CharacterData])
    func charactersRequestFailed(message: String)
}

protocol ListViewBasis: class {
    func failedCharactersRequest(message: String)
    func onShowCharactersList(charactersViewInfo: [CharacterViewInfo])
}
