//
//  SplashPresenter.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import Foundation

protocol SplashPresenterType {
    func onSplashPresented(on splashView: SplashViewControllerType)
}

protocol SplashPresenterRouterDelegate: class {
    func routeToHome(from splashView: SplashViewControllerType)
}

final class SplashPresenter {
    private let interactor: SplashInteractorType
    private weak var routerDelegate: SplashPresenterRouterDelegate?
    
    weak var splashView: SplashViewControllerType?
    
    init(interactor: SplashInteractorType, routerDelegate: SplashPresenterRouterDelegate) {
        self.interactor = interactor
        self.routerDelegate = routerDelegate
    }
}

extension SplashPresenter: SplashPresenterType {
    func onSplashPresented(on splashView: SplashViewControllerType) {
        self.splashView = splashView
        self.interactor.performTimeout()
    }
}

extension SplashPresenter: SplashInteractorDelegate {
    func onTimeoutPerformed() {
        guard let splashView = self.splashView else {
            assertionFailure("splashView should be available on SplashPresenter")
            return
        }
        self.routerDelegate?.routeToHome(from: splashView)
    }
}
