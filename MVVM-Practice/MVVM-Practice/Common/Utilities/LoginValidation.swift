//
//  Validation.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 27/10/2021.
//

import Foundation

final class LoginValidation: NSObject{
    
    private  override init(){
        super.init()
        
    }
    static func usernameValidation(_ username: String)->Bool {
        
        return username.count > 3 && username.count < 10
    }
    static func passwordValidation(_ password: String)-> Bool{
        
        return password.count > 4 && password.count < 10
    }
    static func checkInternetConnectivity(){
        
    }
}


