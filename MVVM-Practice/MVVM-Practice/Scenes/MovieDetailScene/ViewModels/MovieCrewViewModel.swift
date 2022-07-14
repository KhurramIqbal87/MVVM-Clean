//
//  MovieCrewViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 28/02/2022.
//

import Foundation

class MovieCrewViewModel: MovieCrewViewModelType{
  
    
    private var name: String = ""
    private var profilePath: String = ""
    private var department: String = ""
    
    func getName()->String{
       return self.name
    }
    func getImage(completion: @escaping((_ imageData: Data?)->Void)){
        self.getImage(relativePath: self.profilePath, width: 400) { imageData in
            guard let imageData = imageData else{return}
            completion(imageData)
            
        }
    }
    func getDepartment() -> String {
        return self.department
    }
}

extension MovieCrewViewModel{
    static func convertModelToViewModel(crew: MovieCrewModel)->MovieCrewViewModel{
        let crewVM = MovieCrewViewModel()
        crewVM.department = crew.job
        crewVM.name = crew.name
        crewVM.profilePath = crew.profileImageURL ?? ""
        
        return crewVM
    }
}


