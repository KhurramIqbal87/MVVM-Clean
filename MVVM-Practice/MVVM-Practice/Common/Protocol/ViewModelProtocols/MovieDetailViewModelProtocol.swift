//
//  MovieDetailViewModelProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 16/02/2022.
//

import Foundation
import UIKit

 protocol MovieDetailViewModelProtocol: ViewLifeCycleProtocol{
     var releaseDate: String{get}
     var overview: String{get}
     var imagePath: String{get}
     var title: String{get}
     var id: Int{get}
//     var cast: [MovieCastModel]{get}
//     var crew: [MovieCrewModel]{get}
     
     var didLoad: (()->Void)? { get set }
     func navigateBack()
     func getCrew()->[MovieCrewViewModelProtocol]
     func getCast()->[MoiveCastViewModelProtocol]
     func getGenre()->[GenreViewModelProtocol]
    
     func getImage(imagePath: String, compeletion: @escaping ((_ image: Data) -> Void))
     
}
