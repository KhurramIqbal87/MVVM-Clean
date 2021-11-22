//
//  LoginError.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 04/11/2021.
//

import Foundation



public enum NetworkError{
    case noInternet
    case networkError(error: HTTPStatusCode)
    
}
