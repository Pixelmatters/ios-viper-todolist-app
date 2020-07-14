//
//  HomeRouter.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import UIKit

protocol HomeRouterType {
    func routeToHome()
}

protocol HomeRouterDelegate: class { }

final class HomeRouter {
    private weak var appViewController: AppViewControllerType?
    private weak var storeService: StoreServiceType?
    private weak var navigationController: UINavigationController?
    private weak var modalController: ViewController?
    private weak var routerDelegate: HomeRouterDelegate?
    
    init(appViewController: AppViewControllerType, storeService: StoreServiceType, routerDelegate: HomeRouterDelegate) {
        self.appViewController = appViewController
        self.storeService = storeService
        self.routerDelegate = routerDelegate
    }
}

extension HomeRouter: HomeRouterType {
    func routeToHome() {
        guard let storeService = self.storeService else {
            assertionFailure("storeService should be present on HomeRouter")
            return
        }
        let interactor = HomeInteractor(storeService: storeService)
        let presenter = HomePresenter(interactor: interactor, routerDelegate: self)
        interactor.interactorDelegate = presenter
        let viewController = HomeViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        self.appViewController?.updateCurrent(to: navigationController)
    }
}

extension HomeRouter: HomePresenterRouterDelegate {
    func routeToCreateTodo(from homeView: HomeViewControllerType) {
        // todo
    }
}
