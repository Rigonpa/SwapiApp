//
//  DetailRouter.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 01/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

final class DetailRouter {
    
    var mainRouter: MainRouterAppProtocols?
    
    static func create(withIdentifier identifier: String) -> UIViewController? {
        
        let router = DetailRouter()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let view = DetailView(characterIdentifier: identifier)
        let serviceLocator = UIApplication.serviceLocator
        let mainRouter = serviceLocator.mainRouter
        
        router.mainRouter = mainRouter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        presenter.characterId = identifier
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.networkManager = serviceLocator.networkManager
        
        return view
    }
}

extension DetailRouter: DetailRouterBasis {
    func popViewController() {
        mainRouter?.navigationController?.popViewController(animated: true)
    }
}
