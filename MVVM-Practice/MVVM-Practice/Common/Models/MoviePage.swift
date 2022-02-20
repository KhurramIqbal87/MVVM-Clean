//
//  Movie.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

struct MoviePage: Decodable{
    var currentPage: Int
    var totalPage: Int
    var movies: [Movie]
    
    enum CodingKeys: String,CodingKey{
        case movies = "results"
        case totalPage = "total_pages"
        case currentPage = "page"
    }
}
