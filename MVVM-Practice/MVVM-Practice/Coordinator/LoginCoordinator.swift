//
//  Coordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 18/11/2021.
//

import UIKit



final class LoginCoordinator: Coordinator{
    func childDidFinish(coordinator: Coordinator) {
        
    }
    
    
    private weak var parentCoordinator: Coordinator?
    private weak var navigationController: UINavigationController?
    private(set) var childCordinators: [Coordinator] = []
    
    
    
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator){
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
       
    }
    
    func start() {
        // objectNo 1
        let container = AppContainer()
        let loginViewController = container.makeLoginViewController(coordinator: self)
        
        if let viewModel = container.getLoginViewModel() as? DefaultLoginViewModel{
            viewModel.setCoordinator(coordinator: self)
        }
        self.navigationController?.setViewControllers([loginViewController], animated: true)
    }
    
    func childDidFinish() {
        self.parentCoordinator?.childDidFinish(coordinator: self)
    }
   
}



