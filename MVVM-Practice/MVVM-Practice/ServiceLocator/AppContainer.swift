//
//  AppContainer.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 17/11/2021.
//

import Foundation

import UIKit
class AppContainer{
    lazy private var resolver: Container = {
        return Container.init()
    }()
    
    func makeLoginViewController()->UIViewController {
        
        self.makeLoginViewModel()
        
        
        let viewController:LoginViewController = LoginViewController.instantiate(nil, resolver: resolver)
        
        return viewController
        
        
    }
    
    func makeLoginViewModel(){
        
        self.makeLoginRepository()
        resolver =  self.resolver.register(LoginViewModelProtocol.self) { resolver in
            return DefaultLoginViewModel.init(repository: try! self.resolver.resolve(type: LoginRepositoryProtocol.self))
        }
    }
    
    func makeLoginRepository(){
        self.makeNetworkManager()
        resolver = self.resolver.register(LoginRepositoryProtocol.self) { resolver in
            return DefaultLoginRepository.init(networkManager: try! self.resolver.resolve(type: NetworkProtocol.self))
        }
        
    }
    
    func makeNetworkManager(){
        resolver =  self.resolver.register(interface: NetworkProtocol.self, instance: NetworkManager.sharedInstance)
        
    }
    
    func makeDatabaseManager(){
        
    }
}


