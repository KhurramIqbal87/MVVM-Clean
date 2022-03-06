//
//  MovieDetail.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 15/02/2021.
//

import Foundation

struct MovieCredit: Decodable{
    var id: Int
    var cast: [MovieCastModel]
    var crew: [MovieCrewModel]
    
    
    enum CodingKeys: String,CodingKey{
        case id = "id"
        case cast = "cast"
        case crew = "crew"
      
    }
}

