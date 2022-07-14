//
//  MovieCastViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 04/03/2022.
//

import Foundation

class MovieCastViewModel: MoiveCastViewModelType{
  
    
    private var name: String = ""
    private var profilePath: String = ""
    
    func getName()->String{
       return self.name
    }
    func getImage(completion: @escaping((_ imageData: Data?)->Void)){
        self.getImage(relativePath: self.profilePath, width: 400) { imageData in
            guard let imageData = imageData else{return}
            completion(imageData)
            
        }
    }
    
}

extension MovieCastViewModel{
    static func convertModelToViewModel(cast: MovieCastModel)-> MovieCastViewModel{
        let castVM = MovieCastViewModel()
        castVM.name = cast.name
        castVM.profilePath = cast.profileImageURL ?? ""
        
        return castVM
    }
}


