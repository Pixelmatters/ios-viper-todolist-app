//
//  HomeRouter.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import UIKit

protocol HomeRouterType {
    func startModule()
}

protocol HomeRouterDelegate: class { }

final class HomeRouter {
    private weak var appViewController: AppViewControllerType?
    private weak var storeService: StoreServiceType?
    private weak var navigationController: UINavigationController?
    private weak var modalNavigationController: UINavigationController?
    private weak var routerDelegate: HomeRouterDelegate?
    
    init(appViewController: AppViewControllerType, storeService: StoreServiceType, routerDelegate: HomeRouterDelegate) {
        self.appViewController = appViewController
        self.storeService = storeService
        self.routerDelegate = routerDelegate
    }
}

extension HomeRouter: HomeRouterType {
    func startModule() {
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
    func routeToAddTodo(from homeView: HomeViewControllerType) {
        let viewController = AddTodoViewController(presenter: homeView.presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
        self.modalNavigationController = navigationController
    }
    
    func dismissAddTodo() {
        self.modalNavigationController?.dismiss(animated: true, completion: {
            self.modalNavigationController = nil
        })
    }
}
