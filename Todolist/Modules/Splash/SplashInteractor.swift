//
//  SplashInteractor.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import Foundation

protocol SplashInteractorType {
    var interactorDelegate: SplashInteractorDelegate? { get set }
    
    func performTimeout()
}

protocol SplashInteractorDelegate: class {
    func onTimeoutPerformed()
}

final class SplashInteractor {
    weak var interactorDelegate: SplashInteractorDelegate?
}

extension SplashInteractor: SplashInteractorType {
    func performTimeout() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.interactorDelegate?.onTimeoutPerformed()
        }
    }
}
