//
//  TodoTableViewCell.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import UIKit

protocol TodoTableViewCellDelegate: class {
    func onTap(todo: Todo)
}

class TodoTableViewCell: TableViewCell {
    
    weak var delegate: TodoTableViewCellDelegate?
    
    var todo: Todo? {
        didSet {
            self.todoTitle.text = self.todo?.title
            self.todoCompleted.setImage((self.todo?.completed ?? false) ? Asset.checked.image : Asset.unchecked.image, for: .normal)
        }
    }
    
    private lazy var todoCompleted: UIButton = {
        let todoCompleted = UIButton(frame: .zero)
        todoCompleted.translatesAutoresizingMaskIntoConstraints = false
        todoCompleted.setImage(Asset.unchecked.image, for: .normal)
        todoCompleted.addTarget(self, action: #selector(onCheckTap), for: .touchUpInside)
        return todoCompleted
    }()
    
    private lazy var todoTitle: UILabel = {
        let todoTitle = UILabel(frame: .zero)
        todoTitle.translatesAutoresizingMaskIntoConstraints = false
        todoTitle.numberOfLines = 0
        return todoTitle
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        self.todoCompleted,
        self.todoTitle
       ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8.0
        return stackView
    }()
    
    override func addSubviews() {
        self.contentView.addSubview(self.stackView)
    }
    
    override func addConstraints() {
        let constraints: [NSLayoutConstraint] = [
            self.todoCompleted.widthAnchor.constraint(equalToConstant: 24),
            self.todoCompleted.heightAnchor.constraint(equalToConstant: 24),
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func onCheckTap(event: UIButton) {
        guard let todo = self.todo else {
            assertionFailure("todo should be available on TodoTableViewCell")
            return
        }
        self.delegate?.onTap(todo: todo)
    }
}
