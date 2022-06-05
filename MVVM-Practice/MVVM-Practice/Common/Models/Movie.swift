//
//  Movie.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

struct Movie: Decodable{
    var id: UInt32
    var title: String
    var poster_path: String?
    var genre_ids: [Int]
    var vote_average: Double
    var popularity: Double
    var release_date: String?
    var overview: String
   
    enum CodingKeys: String,CodingKey{
        case id = "id"
        case title = "title"
        case poster_path = "poster_path"
        case genre_ids = "genre_ids"
        case vote_average = "vote_average"
        case popularity = "popularity"
        case release_date = "release_date"
        case overview = "overview"
        
    }
}
