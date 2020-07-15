//
//  AddTodoViewController.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import UIKit

protocol AddTodoViewControllerType: class {
    var presenter: HomePresenterType { get }
}

class AddTodoViewController: ViewController {
    var presenter: HomePresenterType
    
    var todoTitle: String? {
        didSet {
            self.button.isEnabled = self.isTodoTitleValid()
        }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Todo"
        label.textColor = .orange
        label.font = .boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Buy eggs..."
        textField.addTarget(self, action: #selector(self.textfieldDidChange), for: .editingChanged)
        textField.borderStyle = .roundedRect
        textField.tintColor = .orange
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.onAddTodoTapped), for: .touchUpInside)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.isEnabled = self.isTodoTitleValid()
        return button
    }()
    
    init(presenter: HomePresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.closeTapped))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textField.becomeFirstResponder()
    }
    
    override func addSubviews() {
        self.view.addSubview(self.label)
        self.view.addSubview(self.textField)
        self.view.addSubview(self.button)
    }
    
    override func addConstraints() {
        let constraints: [NSLayoutConstraint] = [
            self.label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            self.label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            self.label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            
            self.textField.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 16.0),
            self.textField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            self.textField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            
            self.button.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 16.0),
            self.button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            self.button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func textfieldDidChange(textField: UITextField) {
        self.todoTitle = textField.text
    }
    
    @objc func onAddTodoTapped(sender: UIButton) {
        guard let title = self.todoTitle else {
            return
        }
        self.presenter.onAddTodoTapped(on: self, title: title)
    }
    
    @objc func closeTapped() {
        self.presenter.onCloseTapped(on: self)
    }
    
    private func isTodoTitleValid() -> Bool {
        return (self.todoTitle?.count ?? 0) > 0
    }
}

extension AddTodoViewController: AddTodoViewControllerType { }
