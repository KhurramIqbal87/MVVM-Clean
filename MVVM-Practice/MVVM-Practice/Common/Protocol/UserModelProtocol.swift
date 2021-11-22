//
//  UserModelProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 06/11/2021.
//

import Foundation

public protocol UserModelProtocol {
    var firstName: String{get}
    var lastName: String?{get}
    var contactNumber: String?{get}
}
protocol UserViewModelProtocol{
    var fullName: String{get}
}
