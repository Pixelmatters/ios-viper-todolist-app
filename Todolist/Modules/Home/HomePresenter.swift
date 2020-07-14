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
    func onTodoTapped(on homeView: HomeViewControllerType, todo: Todo)
    func onTodoDeleted(on homeView: HomeViewControllerType, todo: Todo)
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
    
    func onTodoTapped(on homeView: HomeViewControllerType, todo: Todo) {
        self.homeView = homeView
        self.interactor.updateTodo(todo: todo)
    }
    
    func onTodoDeleted(on homeView: HomeViewControllerType, todo: Todo) {
        self.homeView = homeView
        self.interactor.deleteTodo(todo: todo)
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
