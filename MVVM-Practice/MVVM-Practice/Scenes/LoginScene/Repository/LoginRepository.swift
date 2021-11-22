//
//  LoginRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 03/11/2021.
//

import Foundation


class DefaultLoginRepository: LoginRepositoryProtocol{
    
    private var networkManager: NetworkProtocol
    init (networkManager: NetworkProtocol){
        self.networkManager = networkManager
    }
    func login(request: Request, completion: ((NetworkError?, Bool, UserModel?) -> Void)?) {
        
        if self.validateLoginCredential(request: request){
            
            let userModel: DefaultUserModel = DefaultUserModel.init(firstName: "khurram", lastName: "Iqbal", contactNumber: "03312275651")
            
            completion?(nil, true, userModel)
            
        } else{
            completion?(NetworkError.networkError(error: .BadRequest), false, nil)
        }
    }
    
    
    private func validateLoginCredential(request: Request)-> Bool{
        
        
        if let username = request["username"] as? String, let password = request["password"] as? String, username.lowercased() == "khurram", password == "12345678"{
            return true
        }
        return false
    }
}








