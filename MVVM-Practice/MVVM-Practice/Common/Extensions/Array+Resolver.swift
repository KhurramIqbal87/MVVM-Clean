//
//  Array+Resolver.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 17/11/2021.
//

import Foundation
 extension Array: Resolver where Element == Resolver {

    /// tries to resolve to an instance of `ServiceType` and returns the instance as soon as the first element(resolver)
    /// resolves it successfully.
    func resolve<ServiceType>(type: ServiceType.Type) throws -> ServiceType {
        guard !isEmpty else { throw EmptyResolverError() }

        return try firstToResolve({ try $0.resolve(type: type) })
    }

     func resolve<ServiceType>() throws -> ServiceType {
        return try resolve(type: ServiceType.self)
    }

    struct EmptyResolverError: Error { }
}
