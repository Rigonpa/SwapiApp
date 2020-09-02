//
//  LocatorSelector.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 02/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

final class ServiceLocator {
    
    lazy var networkManager: NetworkManagerProtocol = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    lazy var mainRouter: MainRouterAppProtocols = {
        let window = UIApplication.shared.windows.first
        let mainRouter = MainRouter(window: window)
        return mainRouter
    }()
    
}

extension UIApplication {
    static var serviceLocator: ServiceLocator = ServiceLocator()
}
