//
//  HomeViewController.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import UIKit

protocol HomeViewControllerType: class {
    var presenter: HomePresenterType { get }

    func onTodosFetched(todos: [Todo])
}

class HomeViewController: ViewController {
    var presenter: HomePresenterType
    
    private var todos: [Todo]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(presenter: HomePresenterType) {
        self.presenter = presenter
        self.todos = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.onHomePresenter(on: self)
    }
    
    override func addSubviews() {
        self.view.addSubview(self.tableView)
    }
    
    override func addStyle() {
        self.view.backgroundColor = .lightGray
    }
    
    override func addConstraints() {
        let constraints: [NSLayoutConstraint] = [
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension HomeViewController: HomeViewControllerType {
    func onTodosFetched(todos: [Todo]) {
        self.todos = todos
        self.tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: .zero)
        let todo = self.todos[indexPath.row]
        cell.textLabel?.text = todo.title
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Did select row
    }
}
