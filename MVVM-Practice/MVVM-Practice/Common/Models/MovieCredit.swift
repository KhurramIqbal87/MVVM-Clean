//
//  MovieDetail.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 15/02/2021.
//

import Foundation

struct MovieCredit: Decodable{
    var name: String
    var profileImageURL: String
    var crew: [MovieCrewModel]
    var cast: [MovieCastModel]
    
    
    enum CodingKeys: String,CodingKey{
        case name = "name"
        case profileImageURL = "profile_path"
        case crew = "crew"
        case cast = "cast"
    }
}

