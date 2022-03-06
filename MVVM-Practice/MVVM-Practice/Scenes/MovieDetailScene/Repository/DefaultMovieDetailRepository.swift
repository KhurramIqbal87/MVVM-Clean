//
//  MovieDetailRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 28/02/2022.
//

import Foundation
import Foundation
class DefaultMovieDetailRepository: MovieDetailImageRepositoryProtocol{
    
    
   
    private let networkSharedInstance = NetworkManager.sharedInstance
   
    private var networkManager: NetworkProtocol
    init (networkManager: NetworkProtocol){
        self.networkManager = networkManager
    }
    func getGenre(completion: @escaping (([Genre]) -> Void)) {
        let genreURL = MovieConstants.getGenreURl()
        
        networkManager.makeHTTPRequest(httpMethod: .GET, endPoint: genreURL, parameters: nil) { (success, error: NetworkError?, genre: GenreModel?) in
            if success{
                completion(genre?.genres ?? [])
            }
            
        }
    }
    func getMovieDetails(movieID: Int, completion: @escaping (MovieDetail?) -> Void) {
        let movieDetailUrl = MovieConstants.getMovieDetailURl(movieId: movieID)
       
        networkManager.makeHTTPRequest(httpMethod: .GET, endPoint: movieDetailUrl, parameters: nil) { (success, error: NetworkError?, movieDetail: MovieDetail?) in
            
        }
    }
    
    func getMovieCredits(movieID: Int, completion: @escaping (MovieCredit?) -> Void) {
        let movieCreditUrl = MovieConstants.getMovieCreditURl(movieId: movieID)
       
        networkManager.makeHTTPRequest(httpMethod: .GET, endPoint: movieCreditUrl, parameters: nil) { (success, error: NetworkError?, movieCredit: MovieCredit?) in
            if success{
                completion(movieCredit)
            }
        }
    }
    
}
