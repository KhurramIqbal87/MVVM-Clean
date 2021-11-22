//
//  Collection+FirstToResolve.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 17/11/2021.
//

import Foundation
extension Collection where Index == Int {

    /// tries to resolve the `ServiceType` and returns the instance as soon as the first element resolves it successfully.
    func firstToResolve<ServiceType>(_ factory: (Element) throws -> ServiceType) throws -> ServiceType {
        for element in self {
            if let resolved = try? factory(element) { return resolved }
        }

        throw Container.unableToResolve(ServiceType.self)
    }
}
