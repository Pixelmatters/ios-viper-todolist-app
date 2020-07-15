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
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Todolist"
        label.font = .boldSystemFont(ofSize: 24.0)
        label.textColor = .orange
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoTableViewCell")
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addTodoTapped))
    }
    
    override func addSubviews() {
        self.view.addSubview(self.label)
        self.view.addSubview(self.tableView)
    }
    
    override func addConstraints() {
        let constraints: [NSLayoutConstraint] = [
            self.label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            self.tableView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 16.0),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func addTodoTapped() {
        self.presenter.onAddTodoTapped(on: self)
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
        guard let todoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as? TodoTableViewCell else {
            return UITableViewCell()
        }
        todoTableViewCell.todo = self.todos[indexPath.row]
        todoTableViewCell.delegate = self
        return todoTableViewCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todo = self.todos[indexPath.row]
            self.presenter.onTodoDeleted(on: self, todo: todo)
        }
    }
}

extension HomeViewController: TodoTableViewCellDelegate {
    func onTap(todo: Todo) {
        self.presenter.onTodoTapped(on: self, todo: todo)
    }
}
