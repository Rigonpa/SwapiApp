//
//  MainRouter.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 02/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

typealias MainRouterAppProtocols = MainRouterAppStartProtocol & MainRouterAppManagementProtocol

protocol MainRouterAppStartProtocol {
    func installMainViewController()
}

protocol MainRouterAppManagementProtocol {
    var rootViewController: UIViewController? { get }
    var navigationController: UINavigationController? { get }
    var currentViewController: UIViewController? { get }
    
    func push(viewController: UIViewController)
}

final class MainRouter {
    let window: UIWindow?
    init(window: UIWindow?) {
        self.window = window
    }
    
    func installRootView() {
        guard let listVC = ListRouter.create() else { return }
        let navigationController = UINavigationController(rootViewController: listVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

extension MainRouter: MainRouterAppStartProtocol {
    func installMainViewController() {
        installRootView()
    }
}

extension MainRouter: MainRouterAppManagementProtocol {
    var rootViewController: UIViewController? {
        return window?.rootViewController
    }
    
    var navigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
    
    var currentViewController: UIViewController? {
        var currentViewController: UIViewController?
        
        if let navManager = navigationController {
            currentViewController = navManager.topViewController
        } else {
            currentViewController = rootViewController
        }
        
        while let presentedViewController = navigationController?.presentedViewController, !presentedViewController.isBeingDismissed {
            
            if let presentedNavViewController = presentedViewController as? UINavigationController {
                currentViewController = presentedNavViewController
            } else {
                currentViewController = presentedViewController
            }
        }
        
        return currentViewController
    }
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
