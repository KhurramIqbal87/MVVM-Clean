//
//  AppContainer.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 17/11/2021.
//

import Foundation

import UIKit
class AppContainer{
     private  var resolver: Container?
    init() {
        resolver = Container()
    }
    func makeLoginViewController(coordinator: LoginCoordinator)->UIViewController {
        
        self.makeLoginViewModel()
        
        resolver = resolver?.register(Coordinator.self, { _ in
            return coordinator
        })
        let viewController:LoginViewController = LoginViewController.instantiate(nil, resolver: resolver)
        
        return viewController
        
        
    }
    
    private func makeLoginViewModel(){
        
        self.makeLoginRepository()
        guard let resolver = self.resolver else{return}
        self.resolver =  resolver.register(LoginViewModelProtocol.self) { resolver in
            return DefaultLoginViewModel.init(repository: try! resolver.resolve(type: LoginRepositoryProtocol.self))
        }
    }
    
     private func makeLoginRepository(){
        self.makeNetworkManager()
        guard let resolver = self.resolver else{return}
        self.resolver = resolver.register(LoginRepositoryProtocol.self) { resolver in
            return DefaultLoginRepository.init(networkManager: try! resolver.resolve(type: NetworkProtocol.self))
        }
        
    }
    
    private  func makeNetworkManager(){
        guard let resolver = self.resolver else{return}
        self.resolver =  resolver.register(interface: NetworkProtocol.self, instance: NetworkManager.sharedInstance)
        
    }
    
   private func makeDatabaseManager(){
        
    }
     func getLoginViewModel()->LoginViewModelProtocol?{
        return try? self.resolver?.resolve(type: LoginViewModelProtocol.self)
    }
    deinit {
       print( "App Container deinit")
    }
}


