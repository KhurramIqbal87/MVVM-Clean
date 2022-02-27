//
//  MovieListRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation
typealias MovieDetailImageRepositoryProtocol = MovieDetailRepositoryProtocol & PosterImageRepositoryProtocol
protocol MovieDetailRepositoryProtocol{
    func getMovieDetails(movieID: Int, completion:@escaping (_ moviePage: MovieDetail?)->Void)
    func getMovieCredits(movieID: Int, completion:@escaping (_ moviePage: MovieCredit?)->Void)
}


    
    

