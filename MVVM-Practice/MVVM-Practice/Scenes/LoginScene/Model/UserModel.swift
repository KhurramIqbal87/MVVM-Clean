//
//  UserModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 03/11/2021.
//

import Foundation

typealias UserModel = UserModelProtocol & UserViewModelProtocol

struct DefaultUserModel: UserModel{
    var firstName: String
    var lastName: String?
    var contactNumber: String?
    
    var fullName: String{
        get{
            return self.firstName + " " + (self.lastName ?? "")
        }
    }
}




