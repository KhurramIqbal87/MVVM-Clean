//
//  DatabaseProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 07/11/2021.
//

import Foundation


protocol DatabaseProtocol{
    func save(entityName: String, obj: Any)throws
    func fetch(entityName: String,query: String?, completion: ((_ results: [Any]?)->Void))
    func update(entityName: String, query: String)throws-> Bool
    func delete(entityName: String, query: String)throws-> Bool
}







