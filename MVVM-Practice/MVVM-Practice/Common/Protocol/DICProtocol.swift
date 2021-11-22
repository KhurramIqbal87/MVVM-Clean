//
//  AppDI.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 07/11/2021.
//

import Foundation
typealias FactoryClosure = (Container) -> AnyObject // 1
protocol DIContainerProtocol {
    
    func register<T>( type: T.Type, factory: @escaping FactoryClosure)
    func resolve<T>(objectType: T.Type)->T?
    func dispose<T>(type: T.Type)
}







