//
//  GenreViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 06/03/2022.
//

import Foundation
import UIKit
final class GenreViewModel: GenreViewModelProtocol{
    
    private var id: Int
    private var name: String
    
    init(genre: Genre){
        self.id = Int(genre.id)
        self.name = genre.name
        
    }
    func getGenreName()->String{
        return self.name
    }
    
}


protocol GenreViewModelProtocol{
    func getGenreName()->String
}
