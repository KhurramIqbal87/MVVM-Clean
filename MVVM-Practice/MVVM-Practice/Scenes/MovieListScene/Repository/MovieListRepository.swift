//
//  DefaultMovieListRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 24/01/2022.
//

import Foundation
class MovieListRepository: MovieListImageRepositoryType{
    
    private let networkSharedInstance = NetworkManager.sharedInstance
   
    private var networkManager: NetworkProtocol
    init (networkManager: NetworkProtocol){
        self.networkManager = networkManager
    }
    
    
    func getMovies(forIndex: Int = 0, completion: @escaping (MoviePage?) -> Void) {
        
        let movieUrl = MovieConstants.getMovieDiscoverURl(forIndex: forIndex)
        
        networkManager.makeHTTPRequest(httpMethod: .GET, endPoint: movieUrl, parameters: nil) { (success, error: NetworkError?, moviePage: MoviePage?) in
            
            if success{
                completion(moviePage)
            }
            
        }
    }
    
}
