//
//  LoginViewModelProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 06/11/2021.
//

import Foundation
import UIKit

protocol MovieItemListViewModelProtocol: PosterImageRepositoryProtocol{
 
    var cellReusableIdentifier: String{get}
    var title: String?{get}
    var rating: Double?{get}
    var releaseDate: String {get}
    var genreNames: [String]{get}
    var posterImage: String{get}
    
    func getRatings()-> String
    func getTitle()->String
    func getImage(completion: @escaping ((_ image: Data?)->Void))
    func getFormattedReleaseDate()->String
    
   
}







