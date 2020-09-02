//
//  DetailContract.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 01/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol DetailRouterBasis {
    func popViewController()
}

protocol DetailPresenterBasis {
    func viewIsReady(characterId: String)
}

protocol DetailInteractorBasis {
    func downloadCharacterData(withIdentifier identifier: String)
}

protocol DetailInteractorOutput: class {
    func downloadedCharacterData(characterData: CharacterData)
    func failedCharacterRequest(message: String)
}

protocol DetailViewBasis: class {
    func onShowingCharacterData(characterData: CharacterData)
    func onShowingRequestError(message: String)
}


