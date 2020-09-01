//
//  ListRouter.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 31/08/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

final class ListRouter {
    var rootNavigationController = UINavigationController()
    
    static func create() -> UINavigationController? {
        let router = ListRouter()
        let presenter = ListPresenter()
        let interactor = ListInteractor()
        let view = ListView()
        
        let navigationController = UINavigationController(rootViewController: view)
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        
        return navigationController
    }
}

extension ListRouter: ListRouterBasis {
    func characterIsSelected(withIdentifier identifier: String) {
        print("Pasar a la pantalla detalle!!!")
        guard let detailView = DetailRouter.create(withIdentifier: identifier) else { return }
        rootNavigationController.pushViewController(detailView, animated: true)
    }
}
