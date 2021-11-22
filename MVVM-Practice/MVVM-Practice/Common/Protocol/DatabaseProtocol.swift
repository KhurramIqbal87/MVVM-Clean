//
//  AppDI.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 07/11/2021.
//

import Foundation


protocol DatabaseProtocol{
    func save(obj: Any)throws
    func fetch(query: String?)->[Any]?
    func update(query: String)throws-> Bool
    func delete(query: String)throws-> Bool
}







