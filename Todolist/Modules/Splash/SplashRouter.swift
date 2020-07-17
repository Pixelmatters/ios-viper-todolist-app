//
//  SplashRouter.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import Foundation

protocol SplashRouterType {
    func startModule()
}

protocol SplashRouterDelegate: class {
    func routeToHome()
}

class SplashRouter {
    private weak var appViewController: AppViewControllerType?
    private weak var routerDelegate: SplashRouterDelegate?
    
    init(appViewController: AppViewControllerType, routerDelegate: SplashRouterDelegate) {
        self.appViewController = appViewController
        self.routerDelegate = routerDelegate
    }
}

extension SplashRouter: SplashRouterType {
    func startModule() {
        let interactor = SplashInteractor()
        let presenter = SplashPresenter(interactor: interactor, routerDelegate: self)
        interactor.interactorDelegate = presenter
        let viewController = SplashViewController(presenter: presenter)
        self.appViewController?.updateCurrent(to: viewController)
    }
}

extension SplashRouter: SplashPresenterRouterDelegate {
    func routeToHome(from splashView: SplashViewControllerType) {
        self.routerDelegate?.routeToHome()
    }
}
