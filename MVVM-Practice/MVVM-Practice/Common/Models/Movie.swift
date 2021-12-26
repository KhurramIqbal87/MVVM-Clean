//
//  Movie.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

struct Movie: Codable{
    var id: UInt32
    var title: String
    var poster_path: String
    var genre_ids: [Genre]
    var vote_average: Double
    var popularity: Double
    var release_date: String
    var overview: String
}
