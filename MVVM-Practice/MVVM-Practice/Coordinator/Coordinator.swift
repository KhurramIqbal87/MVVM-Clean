//
//  Coordinator.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 18/11/2021.
//

import UIKit

protocol Coordinator: AnyObject{
    func start()
    func childDidFinish(coordinator: Coordinator)
    
    
}







