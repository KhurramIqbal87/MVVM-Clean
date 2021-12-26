//
//  MovieListRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

protocol PosterImageRepositoryProtocol{
    func getImage(relativePath: String, completion:@escaping (_ imageData: Data?)->Void)
}

class PosterImageRepository: PosterImageRepositoryProtocol{
    private let networkSharedInstance = NetworkManager.sharedInstance
   
    func getImage(relativePath: String, completion: @escaping (Data?) -> Void) {
        
        let url = MovieConstants.IMAGES_URL  + relativePath
        networkSharedInstance
    }
    
}
