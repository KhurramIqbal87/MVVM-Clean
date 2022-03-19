//
//  MovieListRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

protocol PosterImageRepositoryProtocol{
    func getImage(relativePath: String, width: Float, completion:@escaping (_ imageData: Data?)->Void)
}
extension PosterImageRepositoryProtocol{
    func getImage(relativePath: String, width: Float, completion:@escaping (_ imageData: Data?)->Void){
        let networkSharedInstance = NetworkManager.sharedInstance
        let url = MovieConstants.getImageURL(pixelWidth: width, relativeURL: relativePath)
        networkSharedInstance.downloadData(url: url) { data, error in
            
            completion(data)
        }
    }
}

final class PosterImageRepository: PosterImageRepositoryProtocol{
    
}


