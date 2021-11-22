//
//  CoreDatabaseManager.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 21/11/2021.
//

import Foundation

 final class DatabaseContext{
    var dbManager: DatabaseProtocol
     
    init(dbManager: DatabaseProtocol) {
        self.dbManager = dbManager
    }
}



