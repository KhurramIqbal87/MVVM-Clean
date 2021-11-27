//
//  Coordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 18/11/2021.
//

import UIKit

final class SplashCoordinator: Coordinator{
    
    
    private var navigationController: UINavigationController
    private(set) var childCordinators: [Coordinator] = []
      
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
     
        let splashViewController: SplashViewController = SplashViewController.instantiate(nil, resolver: nil)
        let splashViewModel = SplashViewModel.init(coordinator: self)
     
        splashViewController.setViewModel(splashViewModel: splashViewModel)
        splashViewModel.navigateToLogin = self.navigateToLogin
        navigationController.setViewControllers([splashViewController], animated: true)
    }
    
    func navigateToLogin(){
       
        let loginCoordinator = LoginCoordinator.init(navigationController: self.navigationController, parentCoordinator: self)
        
        loginCoordinator.start()
        self.childCordinators.append(loginCoordinator)
    }
    
    func childDidFinish(coordinator: Coordinator){
     
        
        self.childCordinators.removeAll(where: {$0 === coordinator})
        for cordinator in self.childCordinators{
           
            print("Coordinator in Splash",coordinator)
        }
      
        
    }
}
