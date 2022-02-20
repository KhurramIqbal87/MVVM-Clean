//
//  DefaultMovieListRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 24/01/2022.
//

import Foundation
class DefaultMovieListRepository: MovieListRepositoryProtocol{
    
    private let networkSharedInstance = NetworkManager.sharedInstance
   
    private var networkManager: NetworkProtocol
    init (networkManager: NetworkProtocol){
        self.networkManager = networkManager
    }
    
    
    func getMovies(forIndex: Int = 0, completion: @escaping (MoviePage?) -> Void) {
        
        let movieUrl = MovieConstants.BASE_URL + MovieConstants.DISCOVER_MOVIES + MovieConstants.MOVIE + MovieConstants.QUERY_APIKEY + MovieConstants.QUERY_PAGE + "\(forIndex)"
       
        networkManager.makeHTTPRequest(httpMethod: .GET, endPoint: movieUrl, parameters: nil) { (success, error: NetworkError?, moviePage: MoviePage?) in
            
        }
    }
    
    func getMovieDetail(movieID: Int , completion: @escaping (MoviePage?) -> Void) {
        
        let movieUrl = MovieConstants.BASE_URL  + MovieConstants.MOVIE + MovieConstants.addComponent + "\(movieID )" + MovieConstants.addComponent + MovieConstants.QUERY_APIKEY
       
        networkManager.makeHTTPRequest(httpMethod: .GET, endPoint: movieUrl, parameters: nil) { (success, error: NetworkError?, moviePage: MoviePage?) in
            
        }
    }
   
    
}
