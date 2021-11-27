//
//  AppDI.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 07/11/2021.
//

import Foundation
final class Container{
    
    private var factories: [AnyServiceFactory]
    private var dependency: Resolver?
    
    init( _ resolver: Resolver? = nil){
        self.dependency = resolver
        self.factories = []
    }
    
    init( _ resolver: Resolver? = nil, factories: [AnyServiceFactory]){
        self.dependency = resolver
        self.factories = factories
        
       
    }
    @discardableResult
    func register<ServiceType>(interface: ServiceType.Type , instance: ServiceType )->Container{
        
        return register(interface) { _ in
            instance
        }
    }
    @discardableResult
    func register<ServiceType>(_ interface: ServiceType.Type, _ factory: @escaping(Resolver)->ServiceType )->Container{
        
        let basicServiceFacotry = BasicServiceFactory<ServiceType>(interface) { resolver in
            factory(resolver)
        }
            
        let container =  Container.init(dependency, factories: factories + [AnyServiceFactory.init(basicServiceFacotry)])
        return container
        
    }
    
    
}
extension Container : Resolver{
    public var resolver: Resolver { return self as Resolver }
    func resolve<ServiceType>(type: ServiceType.Type) throws -> ServiceType {
        
        guard let factory = factories.first(where: {$0.supports(type)}) else{
            guard let resolveByDependency = try self.dependency?.resolve(type: type) else{
                throw Container.unableToResolve(type)
            }
            return resolveByDependency
            
        }
        return try factory.resolve(resolver: self)
        
    }
    
    
}

extension Container {
    public static func unableToResolve<ServiceType>(_ type: ServiceType.Type) -> Error {
        return .factoryNotFound(service: type)
    }

    public enum Error: Swift.Error, Equatable {
        
        public static func == (lhs: Container.Error, rhs: Container.Error) -> Bool {
            switch (lhs, rhs) {
            case let (.factoryNotFound(lhsType), .factoryNotFound(rhsType)):
                return lhsType == rhsType
            }
        }

        case factoryNotFound(service: Any.Type)
    }
}


