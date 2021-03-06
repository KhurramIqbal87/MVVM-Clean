//
//  MovieListRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation
typealias MovieDetailImageRepositoryType = MovieDetailRepositoryType & PosterImageRepositoryType
protocol MovieDetailRepositoryType{
    func getMovieDetails(movieID: Int, completion:@escaping (_ moviePage: MovieDetail?)->Void)
    func getMovieCredits(movieID: Int, completion:@escaping (_ moviePage: MovieCredit?)->Void)
    func getGenre(completion: @escaping((_ genres: [Genre])->Void))
}


    
    

