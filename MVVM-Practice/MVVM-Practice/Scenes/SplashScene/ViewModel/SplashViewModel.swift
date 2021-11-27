//
//  SplashViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 27/11/2021.
//

import Foundation

final class SplashViewModel{
    var coordinator: SplashCoordinator?
    var navigateToLogin: (()->Void)?
    static let title = "Splash Screen"
    
    init(coordinator: SplashCoordinator){
        self.coordinator = coordinator
    }
   
    
    func navigateToLoginController(){
        self.navigateToLogin?()
    }
    
}
