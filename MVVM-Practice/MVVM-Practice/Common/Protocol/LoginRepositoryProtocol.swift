//
//  LoginRepositoryProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 06/11/2021.
//

import Foundation
public typealias Request = [String:Any]

 protocol LoginRepositoryProtocol{
    
    func login(request: Request, completion:((_ error: NetworkError?, _ success: Bool, _ userModel: UserModel?) ->Void)?)
    
    
}
