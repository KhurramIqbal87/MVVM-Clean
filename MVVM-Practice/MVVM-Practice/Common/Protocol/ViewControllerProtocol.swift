//
//  ViewControllerProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 17/11/2021.
//

import Foundation

protocol ViewControllerProtocol{
    func injectDependency(_ resolver: Resolver)
}
protocol ViewControllerDismiss {
    func viewWillDisAppear()
}
protocol ViewControllerInitialize{
    func viewDidLoad()
    
}
