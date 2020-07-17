//
//  HomeInteractorTests.swift
//  TodolistTests
//
//  Created by Filipe Santos on 15/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import XCTest
import CoreData

class HomeInteractorTests: XCTestCase {

    private var storeService: StoreServiceType!
    private var interactor: HomeInteractorType!
    private var expectation: XCTestExpectation!
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        return NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodolistTest", managedObjectModel: self.managedObjectModel)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    override func setUpWithError() throws {
        self.storeService = StoreService(container: self.persistentContainer)
        self.interactor = HomeInteractor(storeService: self.storeService)
        self.interactor.interactorDelegate = self
        _ = Todo.save(title: "Test", to: self.storeService.getContext())
    }
    
    override func tearDownWithError() throws {
        Todo.flush(from: self.storeService.getContext())
        self.interactor = nil
        self.storeService = nil
    }
    
    func testAddTodo() throws {
        self.expectation = XCTestExpectation(description: "AddTodo")
        self.interactor.addTodo(title: "AddTodo")
        self.wait(for: [self.expectation], timeout: 1.0)
    }
    
    func testDeleteTodo() throws {
        self.expectation = XCTestExpectation(description: "DeleteTodo")
        let todos = Todo.fetchAll(from: self.storeService.getContext())
        if let todo = todos.first {
            self.interactor.deleteTodo(todo: todo)
            self.wait(for: [self.expectation], timeout: 1.0)
        } else {
            XCTFail("At least 1 todo should be available")
        }
    }
    
    func testUpdateTodo() throws {
        self.expectation = XCTestExpectation(description: "UpdateTodo")
        let todos = Todo.fetchAll(from: self.storeService.getContext())
        if let todo = todos.first {
            todo.completed = !todo.completed
            self.interactor.updateTodo(todo: todo)
            self.wait(for: [self.expectation], timeout: 1.0)
        } else {
            XCTFail("At least 1 todo should be available")
        }
    }

}

extension HomeInteractorTests: HomeInteractorDelegate {
    func onTodoAdded() {
        self.expectation.fulfill()
    }

    func onTodosFetched(todos: [Todo]) {
        self.expectation.fulfill()
    }
    
}
