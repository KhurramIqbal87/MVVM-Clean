//
//  Coordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 18/11/2021.
//

import UIKit

final class AppCoordinator: Coordinator{
    
    private var window: UIWindow
    private(set) var childCordinators: [Coordinator] = []
    
    
    
    init(window: UIWindow){
        self.window = window
    }
    
    func start() {
        let navController = UINavigationController.init()
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        let splashCoordinator = SplashCoordinator.init(navigationController: navController)
        splashCoordinator.start()
        self.childCordinators.append(splashCoordinator)
    }
    
}



