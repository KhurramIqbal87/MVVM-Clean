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
    
    lazy private var container: AppContainer = {
        return AppContainer()
    }()
    
    init(window: UIWindow){
        self.window = window
    }
    
    func start() {
        let nvController = UINavigationController.init()
        let loginViewController = container.makeLoginViewController()
        
        if let viewModel = container.getLoginViewModel() as? DefaultLoginViewModel{
            viewModel.setCoordinator(coordinator: self)
        }
        window.rootViewController = nvController
        nvController.setViewControllers([loginViewController], animated: true)
        window.makeKeyAndVisible()
    }
    
    func viewWillDisAppear() {
        
    }
}



