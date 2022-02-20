//
//  MovieListRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

protocol MovieListRepositoryProtocol{
    func getMovies(forIndex: Int, completion:@escaping (_ moviePage: MoviePage?)->Void)
}


    
    

