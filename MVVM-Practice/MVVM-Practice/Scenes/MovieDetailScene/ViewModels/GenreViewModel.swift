//
//  GenreViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 06/03/2022.
//

import Foundation
import UIKit
final class GenreViewModel: GenreViewModelProtocol{
    
     var id: Int
     var name: String = ""
    
    init(genre: Genre){
        self.id = Int(genre.id)
        self.name = genre.name
        
    }
    init(id: Int){
        self.id = Int(id)
        
    }
    func getGenreName()->String{
        return self.name
    }
    
}


protocol GenreViewModelProtocol{
    func getGenreName()->String
}
