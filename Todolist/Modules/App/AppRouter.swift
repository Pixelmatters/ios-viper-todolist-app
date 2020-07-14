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
    private var homeRouter: HomeRouterType?
    
    init(appViewController: AppViewControllerType, storeService: StoreServiceType) {
        self.appViewController = appViewController
        self.storeService = storeService
    }
    
    private func routeToSplash() {
        self.splashRouter = SplashRouter(appViewController: self.appViewController, routerDelegate: self)
        self.splashRouter?.routeToSplash()
    }
    
    internal func routeToHome() {
        self.homeRouter = HomeRouter(appViewController: self.appViewController, storeService: self.storeService, routerDelegate: self)
        self.homeRouter?.routeToHome()
    }
}

extension AppRouter: AppRouterType {
    func startApplication() {
        self.routeToSplash()
    }
}

extension AppRouter: SplashRouterDelegate { }

extension AppRouter: HomeRouterDelegate { }
