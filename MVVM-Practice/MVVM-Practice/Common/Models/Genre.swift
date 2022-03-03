//
//  Movie.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

struct Genre: Decodable{
    var id: UInt16
    var name: String
    
    enum CodingKeys: String,CodingKey{
        case id = "id"
        case name = "name"
    }

}
