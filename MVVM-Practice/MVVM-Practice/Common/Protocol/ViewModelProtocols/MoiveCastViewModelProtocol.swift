//
//  MoiveCastViewModelProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 03/04/2022.
//

import Foundation
protocol MoiveCastViewModelProtocol: PosterImageRepositoryProtocol{
    func getName()->String
    func getImage(completion: @escaping((_ imageData: Data?)->Void))
    
}
