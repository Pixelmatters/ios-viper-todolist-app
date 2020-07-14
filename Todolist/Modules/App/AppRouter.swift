//
//  AppRouter.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import Foundation

protocol AppRouterType {
    func startApplication()
}

final class AppRouter {
    private let appViewController: AppViewControllerType
    private let storeService: StoreServiceType
    
    private var splashRouter: SplashRouterType?
    
    init(appViewController: AppViewControllerType, storeService: StoreServiceType) {
        self.appViewController = appViewController
        self.storeService = storeService
    }
    
    private func routeToSplash() {
        self.splashRouter = SplashRouter(appViewController: self.appViewController, routerDelegate: self)
        self.splashRouter?.routeToSplash()
    }
}

extension AppRouter: AppRouterType {
    func startApplication() {
        self.routeToSplash()
    }
}

extension AppRouter: SplashRouterDelegate {
    func routeToHome() {
        // route to home
    }
}
