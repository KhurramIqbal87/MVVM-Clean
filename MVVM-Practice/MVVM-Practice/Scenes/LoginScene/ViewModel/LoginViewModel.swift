//
//  LoginViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 03/11/2021.
//

import Foundation


typealias Success = ((_ success: String)->Void)
typealias Failure = ((_ error: String)->Void)

public class DefaultLoginViewModel: LoginViewModelProtocol {

    private var coordinator: Coordinator?
    private var repository: LoginRepositoryProtocol?
    var userViewModel: UserViewModelProtocol?
    var didFinishLogin: (success: Success, error:  Failure)?

    private init(){
        
    }

    init( repository: LoginRepositoryProtocol  ){
        self.repository = repository
    }
    
    func setCoordinator(coordinator: Coordinator){
        self.coordinator = coordinator
    }
    
    func setLoginCompletion(loginCompletion:  (success:Success, error: Failure)){
        self.didFinishLogin = loginCompletion
    }
    
    
    func login(userName: String, password: String) {
        
        if !LoginValidation.usernameValidation(userName) || !LoginValidation.passwordValidation(password){
            self.didFinishLogin?.error("Please input correct username and password")
            return
        }
        
        let dictRequest = ["username": userName,
                    "password": password]
        repository?.login(request: dictRequest, completion: { [weak self] (error, success, userModel)  in
            guard let self = self else{return}
           
            if success{
                
                self.userViewModel = userModel
                self.didFinishLogin?.success("Login Succesful")
            } else{
                guard let errorType = error else{
                    self.didFinishLogin?.error("unKnown error")
                    return
                }
                
                switch errorType{
                case .networkError (let statusCode):
                    self.didFinishLogin?.error(self.showNetworkError(statusCode: statusCode))
                case .noInternet: self.didFinishLogin?.error("No Internet Connection")
                }
            }
            
        })
    }
    
    private func showNetworkError(statusCode: HTTPStatusCode) -> String{
        
        switch statusCode{
        default: return HTTPStatusCodeHelper.codeDescription(statusCode: statusCode)
            
        }
    }
    
    func viewWillDisAppear() {
        if let coordinator = self.coordinator as? LoginCoordinator{
            coordinator.childDidFinish()
        }
    }
    
    func viewDidLoad() {
        
    }
    
    
}














