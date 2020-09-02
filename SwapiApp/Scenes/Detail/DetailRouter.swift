//
//  DetailRouter.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 01/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

final class DetailRouter {
    
    static func create(withIdentifier identifier: String) -> UIViewController? {
        let router = DetailRouter()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let view = DetailView(characterIdentifier: identifier)
        let networkManager = NetworkManager()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.networkManager = networkManager
        
        return view
    }
}

extension DetailRouter: DetailRouterBasis {}
