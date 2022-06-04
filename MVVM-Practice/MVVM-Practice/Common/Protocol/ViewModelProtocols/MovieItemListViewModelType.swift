//
//  LoginViewModelProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 06/11/2021.
//

import Foundation
import UIKit

protocol MovieItemListViewModelType: PosterImageRepositoryType{
 
    var cellReusableIdentifier: String{get}
    var title: String?{get}
    var rating: Double?{get}
    var releaseDate: String {get}
    var genreNames: [String]{get}
    var posterImage: String{get}
    
    func getRatings()-> String
    func getTitle()->String
    func getImage(width: Float, completion: @escaping ((_ image: Data?)->Void))
    func getFormattedReleaseDate()->String
    
   
}







