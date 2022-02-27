//
//  MovieCastModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 28/02/2022.
//

import Foundation
struct MovieCastModel: Decodable{
    public var id: Int
    public var name: String
    public var profileImageURL: String
   
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case profileImageURL = "profile_path"
        case id = "id"
    }
    
}
