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
    
    override func addStyle() {
        self.view.backgroundColor = .red
    }
}

extension SplashViewController: SplashViewControllerType { }
