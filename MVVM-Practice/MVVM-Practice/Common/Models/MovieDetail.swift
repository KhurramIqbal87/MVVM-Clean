//
//  MovieDetail.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 15/02/2021.
//

import Foundation

struct MovieDetail: Decodable{
    var overview: String
    var originalTitle: String
    var id: Int
    
    enum CodingKeys: String,CodingKey{
        case overview = "overview"
        case original_title = "original_title"
        case id = "id"
    }
}

