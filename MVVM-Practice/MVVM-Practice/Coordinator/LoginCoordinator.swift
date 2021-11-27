//
//  Coordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 18/11/2021.
//

import UIKit



final class LoginCoordinator: Coordinator{
    
    private weak var parentCoordinator: Coordinator?
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
 // objectNo 1
        let loginViewController = container.makeLoginViewController(coordinator: self)
    
        if let viewModel = container.getLoginViewModel() as? DefaultLoginViewModel{
            viewModel.setCoordinator(coordinator: self)
        }

//        self.navigationController.setViewControllers([loginViewController], animated: true)
        self.navigationController.pushViewController(loginViewController, animated: true)
    
    }
    
    func childDidFinish() {
        self.parentCoordinator?.childDidFinish(coordinator: self)
    }
}



