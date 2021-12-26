//
//  LoginViewModelProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 06/11/2021.
//

import Foundation

protocol MovieItemListViewModelProtocol{
    
    var title: String?{get}
    var rating: Double?{get}
    var releaseDate: String {get}
    var imageData: Data?{get}
    var genreNames: [String]{get}
    
    
    func getRatings()-> String
    
    func getImage(completion: @escaping ((_ image: Data?)->Void))
    func getFormattedReleaseDate()->String
}







