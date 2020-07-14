//
//  HomeInteractor.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import Foundation

protocol HomeInteractorType {
    func fetchTodos()
}

protocol HomeInteractorDelegate: class {
    func onTodosFetched(todos: [Todo])
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
        
        // Clear all todos
        let todosToClear = Todo.fetchAll(from: context)
        for todo in todosToClear {
            _ = Todo.delete(createdAt: todo.createdAt!, from: context)
        }
        
        // Add dummy
        let dummyTodos = ["Todo 1", "Todo 2", "Todo 3"]
        for dummyTodo in dummyTodos {
            _ = Todo.save(title: dummyTodo, to: context)
        }
        
        // Actual code
        let todos = Todo.fetchAll(from: context)
        self.interactorDelegate?.onTodosFetched(todos: todos)
    }
}
