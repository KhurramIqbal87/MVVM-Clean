//
//  Coordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 18/11/2021.
//

import UIKit

protocol Coordinator: AnyObject{
    func start()
    var childCordinators: [Coordinator]{get}
}

final class AppCoordinator:Coordinator{
    private var window: UIWindow
    init(window: UIWindow){
        self.window = window
    }
    func start() {
        let nvController = UINavigationController.init()
        let container = AppContainer.init()
        let loginViewController = container.makeLoginViewController()
        window.rootViewController = nvController
        nvController.setViewControllers([loginViewController], animated: true)
        window.makeKeyAndVisible()
        
        
        
    }
    
 private(set) var childCordinators: [Coordinator] = []
    

    
    
}



