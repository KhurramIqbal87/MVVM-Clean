//
//  MovieConstants.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 12/12/2021.
//

import Foundation
class MovieConstants{
    static let apiKey = "2d1cb88f5b3634abdb5496b940599634"
    //static var THE_MOVIE_URL = "https://api.themoviedb.org/3/movie"
    static let IMAGES_URL = "https://image.tmdb.org/t/p/original"
    static let BASE_URL = "https://api.themoviedb.org/3"
    
    static let DISCOVER_MOVIES = "/discover"
    static let MOVIE = "/movie"
    static let addComponent = "/"
    static let MOVIE_DETAILS = ""
    static let QUERY_APIKEY = "?api_key=\(apiKey)"
    static let GENRE = "/genre"
    static let creditDetails = "/credits"
    
    //static let VALID_EXPECTED_PATH = "/3/discover/movie?api_key="
    static let QUERY_PAGE = "&page="
    
    static func getMovieDetailURl(movieId: Int)-> String{
        let movieDetailUrl = MovieConstants.BASE_URL  + MovieConstants.MOVIE + MovieConstants.addComponent + "\(movieId )" + MovieConstants.addComponent + MovieConstants.QUERY_APIKEY
        return movieDetailUrl
    }
   
    static func getMovieCreditURl(movieId: Int)-> String{
        let movieCreditUrl = MovieConstants.BASE_URL  + MovieConstants.MOVIE + MovieConstants.addComponent + "\(movieId )" + MovieConstants.addComponent + MovieConstants.QUERY_APIKEY
        return movieCreditUrl
    }
  
    static func getMovieDiscoverURl(forIndex: Int)-> String{
        let movieDiscoverUrl = MovieConstants.BASE_URL + MovieConstants.DISCOVER_MOVIES + MovieConstants.MOVIE + MovieConstants.QUERY_APIKEY + MovieConstants.QUERY_PAGE + "\(forIndex)"
        return movieDiscoverUrl
    }
   
    
}
