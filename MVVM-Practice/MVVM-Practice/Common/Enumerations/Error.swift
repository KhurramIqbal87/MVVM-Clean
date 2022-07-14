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
    case dataSerializationError(error: String)
    case error(error: Error)
    
    func getErrorMessage()->String{
        switch self {
        case .noInternet:
            return "Please Connect to internet"
        case .networkError(_):
            return "Oops technical issue occured"
        case .dataSerializationError(_):
            return "Corrupt data"
        case .error(let error):
            return error.localizedDescription
        }
    }
    
}
