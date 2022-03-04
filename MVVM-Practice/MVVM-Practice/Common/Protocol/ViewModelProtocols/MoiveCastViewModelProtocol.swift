//
//  MoiveCrewViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 28/02/2022.
//

import Foundation
protocol MovieCrewViewModelProtocol: PosterImageRepositoryProtocol{
    func getName()->String
    func getImage(completion: @escaping((_ imageData: Data?)->Void))
    func getDepartment()->String
    
}
