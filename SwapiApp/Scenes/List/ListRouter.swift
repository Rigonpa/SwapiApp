//
//  ListRouter.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 31/08/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class ListRouter {
    
    var mainRouter: MainRouterAppProtocols?
    
    static func create() -> UIViewController? {
        let router = ListRouter()
        let presenter = ListPresenter()
        let interactor = ListInteractor()
        let view = ListView()
        let serviceLocator = UIApplication.serviceLocator
        let networkManager = serviceLocator.networkManager
        
        router.mainRouter = serviceLocator.mainRouter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.networkManager = networkManager
        
        return view
    }
}

extension ListRouter: ListRouterBasis {
    func characterIsSelected(withIdentifier identifier: String) {
        guard let detailView = DetailRouter.create(withIdentifier: identifier) else { return }
        mainRouter?.push(viewController: detailView)
    }
}
