//
//  AppDelegate.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appRouter: AppRouterType?

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Todolist")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appViewController = self.setupAppViewController()
        let storeService = StoreService(container: self.persistentContainer)
        self.appRouter = AppRouter(appViewController: appViewController, storeService: storeService)
        self.appRouter?.startApplication()
        return true
    }
    
    private func setupAppViewController() -> AppViewControllerType {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let appViewController = AppViewController(nibName: nil, bundle: nil)
        self.window?.rootViewController = appViewController
        self.window?.makeKeyAndVisible()
        return appViewController
    }

}

