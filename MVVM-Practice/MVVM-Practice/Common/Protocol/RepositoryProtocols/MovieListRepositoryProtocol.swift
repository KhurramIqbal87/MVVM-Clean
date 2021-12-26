//
//  MovieListRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

protocol MovieListRepositoryProtocol{
    func getMovies(forIndex: Int, completion:@escaping (_ moviePages: [MoviePage]?)->Void)
}

class MovieListRepository: MovieListRepositoryProtocol{
    private let networkSharedInstance = NetworkManager.sharedInstance
    func getMovies(forIndex: Int = 0, completion: @escaping ([MoviePage]?) -> Void) {
        
        let movieUrl = MovieConstants.BASE_URL + MovieConstants.DISCOVER_MOVIES + MovieConstants.MOVIE + MovieConstants.QUERY_APIKEY + MovieConstants.QUERY_PAGE + "\(forIndex)"
       
        networkSharedInstance.getData(nil, nil, url: movieUrl, methodType: .GET) { success, error, response in
            
        }
    }
    
    
}
