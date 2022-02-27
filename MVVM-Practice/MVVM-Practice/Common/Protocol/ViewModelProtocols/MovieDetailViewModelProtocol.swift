//
//  MovieDetailViewModelProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 16/02/2022.
//

import Foundation
import UIKit

 protocol MovieDetailViewModelProtocol: ViewLifeCycleProtocol{
     
     var didLoad: (()->Void)? { get set }
     func getImage(imagePath: String, compeletion: @escaping ((_ image: Data) -> Void))
     func setCoordinator(coordinator: MovieDetailCoordinator)
     func setRepository(repository: MovieDetailImageRepositoryProtocol)
}
