//
//  LoginViewModelProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 06/11/2021.
//

import Foundation

protocol LoginViewModelProtocol: ViewControllerDismiss, ViewControllerInitialize{
    
   
    var userViewModel: UserViewModelProtocol? { get}
   
    var didFinishLogin: (success: Success, error : Failure)?{ get set}

    func setLoginCompletion(loginCompletion:  (success:Success, error: Failure))

    func login(userName: String, password: String)
    
    
}
