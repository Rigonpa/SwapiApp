//
//  ListRouter.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 31/08/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class ListRouter {
    var rootNavigationController = UINavigationController()
    
    static func create() -> UINavigationController? {
        let router = ListRouter()
        let presenter = ListPresenter()
        let interactor = ListInteractor()
        let view = ListView()
        let networkManager = NetworkManager()
        
        let navigationController = UINavigationController(rootViewController: view)
        
        router.rootNavigationController = navigationController
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.networkManager = networkManager
        
        return navigationController
    }
}

extension ListRouter: ListRouterBasis {
    func characterIsSelected(withIdentifier identifier: String) {
        guard let detailView = DetailRouter.create(withIdentifier: identifier) else { return }
        self.rootNavigationController.pushViewController(detailView, animated: true)
    }
}
