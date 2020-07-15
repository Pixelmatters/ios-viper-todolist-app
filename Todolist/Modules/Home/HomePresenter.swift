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
    func onAddTodoTapped(on homeView: HomeViewControllerType)
    func onAddTodoTapped(on addTodoView: AddTodoViewControllerType, title: String)
    func onCloseTapped(on addTodoView: AddTodoViewControllerType)
}

protocol HomePresenterRouterDelegate: class {
    func routeToAddTodo(from homeView: HomeViewControllerType)
    func dismissAddTodo()
}

final class HomePresenter {
    private let interactor: HomeInteractorType
    private weak var routerDelegate: HomePresenterRouterDelegate?
    
    weak var homeView: HomeViewControllerType?
    weak var addTodoView: AddTodoViewControllerType?
    
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
    
    func onAddTodoTapped(on homeView: HomeViewControllerType) {
        self.homeView = homeView
        self.routerDelegate?.routeToAddTodo(from: homeView)
    }
    
    func onAddTodoTapped(on addTodoView: AddTodoViewControllerType, title: String) {
        self.addTodoView = addTodoView
        self.interactor.addTodo(title: title)
    }
    
    func onCloseTapped(on addTodoView: AddTodoViewControllerType) {
        self.addTodoView = addTodoView
        self.routerDelegate?.dismissAddTodo()
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
    
    func onTodoAdded() {
        self.routerDelegate?.dismissAddTodo()
    }
}
