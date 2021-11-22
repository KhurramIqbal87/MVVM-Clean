//
//  Resolver.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 15/11/2021.
//

import Foundation

protocol Resolver{
    func resolve<ServiceType>(type: ServiceType.Type)throws -> ServiceType
}
