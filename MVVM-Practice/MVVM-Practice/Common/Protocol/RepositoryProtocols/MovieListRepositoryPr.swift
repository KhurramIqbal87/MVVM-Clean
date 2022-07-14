//
//  MovieListRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation
typealias MovieListImageRepositoryType = PosterImageRepositoryType & MovieListRepositoryPr
protocol MovieListRepositoryPr: PosterImageRepositoryType{
    func getMovies(forIndex: Int, completion:@escaping (_ moviePage: MoviePage?,_ error: NetworkError?)->Void)
    
}



    
    

