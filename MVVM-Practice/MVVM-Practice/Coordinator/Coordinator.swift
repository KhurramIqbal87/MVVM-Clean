//
//  Coordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 18/11/2021.
//

import UIKit

protocol Coordinator: AnyObject{
    var childCordinators: [Coordinator]{get}
    func start()
    func childDidFinish(coordinator: Coordinator)
    
}
extension Coordinator{

    func childDidFinish(coordinator: Coordinator){
        print("didFinish Call")
    }
}






