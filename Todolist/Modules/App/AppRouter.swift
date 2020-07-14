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
    
    init(appViewController: AppViewControllerType) {
        self.appViewController = appViewController
    }
}

extension AppRouter: AppRouterType {
    func startApplication() {
        // route to splash screen
    }
}
