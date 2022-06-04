//
//  MovieListRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation
typealias MovieListImageRepositoryType = PosterImageRepositoryType & MovieListRepositoryProtocol
protocol MovieListRepositoryProtocol: PosterImageRepositoryType{
    func getMovies(forIndex: Int, completion:@escaping (_ moviePage: MoviePage?)->Void)
    
}



    
    

