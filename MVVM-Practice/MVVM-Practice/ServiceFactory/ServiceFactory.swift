//
//  Resolver.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 15/11/2021.
//

import Foundation

protocol ServiceFactory{
   associatedtype ServiceType
    
    func resolve(_ resolver: Resolver) throws -> ServiceType
}
extension ServiceFactory{
   
    func supports<ServiceType>(_ type: ServiceType.Type) -> Bool {
        return type == ServiceType.self
    }
}
