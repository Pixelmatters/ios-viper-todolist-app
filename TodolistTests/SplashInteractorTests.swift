//
//  SplashInteractorTests.swift
//  TodolistTests
//
//  Created by Filipe Santos on 15/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import XCTest

class SplashInteractorTests: XCTestCase {

    private var interactor: SplashInteractorType!
    private var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        self.interactor = SplashInteractor()
        self.interactor.interactorDelegate = self
    }

    override func tearDownWithError() throws {
        self.interactor = nil
    }

    func testTimeout() throws {
        self.expectation = XCTestExpectation(description: "PerformTimeout")
        self.interactor.performTimeout()
        self.wait(for: [self.expectation], timeout: 3.0)
    }
}

extension SplashInteractorTests: SplashInteractorDelegate {
    func onTimeoutPerformed() {
        self.expectation.fulfill()
    }
}
