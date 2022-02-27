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
    var posterPath: String
    
    enum CodingKeys: String,CodingKey{
        case overview = "overview"
        case originalTitle = "original_title"
        case id = "id"
        case posterPath = "poster_path"
    }
}

