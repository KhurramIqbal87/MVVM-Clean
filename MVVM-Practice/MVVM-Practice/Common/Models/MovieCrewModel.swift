//
//  MovieCrewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 28/02/2022.
//

import Foundation
struct MovieCrewModel: Decodable{
    public var id: Int
    public var name: String
    public var profileImageURL: String
    public var job: String
    
    enum CodingKeys: String,CodingKey{
        case name = "name"
        case profileImageURL = "profile_path"
        case id = "id"
        case job = "job"
    }
}
