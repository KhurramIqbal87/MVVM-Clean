//
//  Resolver.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 15/11/2021.
//

import Foundation


class AnyServiceFactory{
    
    private let resolver: (Resolver)throws -> Any
    private var _supports: (Any.Type) -> Bool
    init<T: ServiceFactory>(_ serviceFactory: T) {
        self.resolver = { resolver in
            try serviceFactory.resolve(resolver)
        }
        self._supports = {$0 == T.ServiceType.self}
    }
    
    func resolve<ServiceType>(resolver: Resolver)throws ->ServiceType{
        
        return try self.resolver(resolver) as! ServiceType
    }
    func supports<ServiceType>(_ serviceType: ServiceType.Type) -> Bool {
        return _supports(serviceType)
    }
}



