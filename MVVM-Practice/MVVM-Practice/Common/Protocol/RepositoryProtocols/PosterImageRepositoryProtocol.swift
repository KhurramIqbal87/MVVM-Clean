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
extension PosterImageRepositoryProtocol{
    func getImage(relativePath: String, completion:@escaping (_ imageData: Data?)->Void){
        let networkSharedInstance = NetworkManager.sharedInstance
        let url = MovieConstants.IMAGES_URL  + relativePath
        networkSharedInstance.downloadData(url: url) { data, error in
            
            completion(data)
        }
    }
}

final class PosterImageRepository: PosterImageRepositoryProtocol{
    
}


