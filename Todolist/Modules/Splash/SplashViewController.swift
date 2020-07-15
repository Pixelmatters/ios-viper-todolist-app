//
//  SplashViewController.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import UIKit

protocol SplashViewControllerType: class {
    var presenter: SplashPresenterType { get }
}

class SplashViewController: ViewController {
    var presenter: SplashPresenterType
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 32.0)
        label.textColor = .orange
        label.text = "Todolist App"
        return label
    }()
    
    init(presenter: SplashPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.onSplashPresented(on: self)
    }
    
    override func addSubviews() {
        self.view.addSubview(self.label)
    }
    
    override func addConstraints() {
        let constraints: [NSLayoutConstraint] = [
            self.label.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension SplashViewController: SplashViewControllerType { }
