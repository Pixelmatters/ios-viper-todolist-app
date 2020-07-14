//
//  HomePresenter.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import Foundation

protocol HomePresenterType {
    func onHomePresenter(on homeView: HomeViewControllerType)
}

protocol HomePresenterRouterDelegate: class {
    func routeToCreateTodo(from homeView: HomeViewControllerType)
}

final class HomePresenter {
    private let interactor: HomeInteractorType
    private weak var routerDelegate: HomePresenterRouterDelegate?
    
    weak var homeView: HomeViewControllerType?
    
    init(interactor: HomeInteractorType, routerDelegate: HomePresenterRouterDelegate) {
        self.interactor = interactor
        self.routerDelegate = routerDelegate
    }
}

extension HomePresenter: HomePresenterType {
    func onHomePresenter(on homeView: HomeViewControllerType) {
        self.homeView = homeView
        self.interactor.fetchTodos()
    }
}

extension HomePresenter: HomeInteractorDelegate {
    func onTodosFetched(todos: [Todo]) {
        guard let homeView = self.homeView else {
            assertionFailure("homeView should be present on HomePresenter")
            return
        }
        homeView.onTodosFetched(todos: todos)
    }
}
