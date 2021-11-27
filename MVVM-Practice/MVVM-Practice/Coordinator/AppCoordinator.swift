//
//  Coordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 18/11/2021.
//

import UIKit





final class AppCoordinator: Coordinator{
    
    private var parentCoordinator: Coordinator
    private var navigationController: UINavigationController
    private(set) var childCordinators: [Coordinator] = []
    
    lazy private var container: AppContainer = {
        return AppContainer()
    }()
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator){
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
 
        let loginViewController = container.makeLoginViewController()
        
        if let viewModel = container.getLoginViewModel() as? DefaultLoginViewModel{
            viewModel.setCoordinator(coordinator: self)
        }

        self.navigationController.pushViewController(loginViewController, animated: true)
    
    }
    
    func viewWillDisAppear() {
        self.parentCoordinator.viewWillDisAppear()
    }
}



