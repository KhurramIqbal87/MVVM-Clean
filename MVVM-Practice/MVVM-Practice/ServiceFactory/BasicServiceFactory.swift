//
//  Resolver.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 15/11/2021.
//

import Foundation

struct BasicServiceFactory<ServiceType>: ServiceFactory{
    
    private let factory : (Resolver)throws -> ServiceType
    

    init(_ type: ServiceType.Type, factory: @escaping(Resolver)throws -> ServiceType) {
        self.factory =  factory
    }

    
    func resolve(_ resolver: Resolver)throws -> ServiceType{
        return try factory(resolver)
    }
}




