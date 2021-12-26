//
//  DefaultMovieListViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation
class MovieItemListViewModel: MovieItemListViewModelProtocol{
    
    var rating: Double?
    var title: String?
    var releaseDate: String = ""
    
    var imageData: Data?
    
    var genreNames: [String] = []
    
    func getFormattedReleaseDate() -> String {
        return self.releaseDate
    }
   
    func getRatings() -> String {
        return "\(self.rating ?? 0.0)"
    }
    
    func getImage(completion: @escaping ((Data?) -> Void)) {
        
    }
    
    
}
