//
//  HomeInteractor.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import Foundation

protocol HomeInteractorType {
    var interactorDelegate: HomeInteractorDelegate? { get set }

    func fetchTodos()
    func updateTodo(todo: Todo)
    func deleteTodo(todo: Todo)
    func addTodo(title: String)
}

protocol HomeInteractorDelegate: class {
    func onTodosFetched(todos: [Todo])
    func onTodoAdded()
}

final class HomeInteractor {
    private let storeService: StoreServiceType
    
    weak var interactorDelegate: HomeInteractorDelegate?
    
    init(storeService: StoreServiceType) {
        self.storeService = storeService
    }
}

extension HomeInteractor: HomeInteractorType {
    func fetchTodos() {
        let context = self.storeService.getContext()
        let todos = Todo.fetchAll(from: context)
        self.interactorDelegate?.onTodosFetched(todos: todos)
    }
    
    func updateTodo(todo: Todo) {
        let context = self.storeService.getContext()
        _ = Todo.update(completed: !todo.completed, createdAt: todo.createdAt!, on: context)
        self.fetchTodos()
    }
    
    func deleteTodo(todo: Todo) {
        let context = self.storeService.getContext()
        _ = Todo.delete(createdAt: todo.createdAt!, from: context)
        self.fetchTodos()
    }
    
    func addTodo(title: String) {
        let context = self.storeService.getContext()
        _ = Todo.save(title: title, to: context)
        self.fetchTodos()
        self.interactorDelegate?.onTodoAdded()
    }
}
