//
//  MovieCastViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 28/02/2022.
//

import Foundation
import UIKit
final class DefaultMovieDetailViewModel: MovieDetailViewModelProtocol{

    var didLoad: (() -> Void)?

    private var coordinator: MovieDetailCoordinator?
    private var repository: DefaultMovieDetailRepository?
    
    func viewDidLoad() {
        
    }
    
    func viewWillDisappear() {
        self.coordinator?.childDidFinish()
    }
    
    func setCoordinator(coordinator: MovieDetailCoordinator) {
        self.coordinator = coordinator
    }
    func setRepository(repository: MovieDetailImageRepositoryProtocol) {
        self.repository = repository as? DefaultMovieDetailRepository
    }
   
    func getImage(imagePath: String, compeletion: @escaping ((Data) -> Void)) {
        self.repository?.getImage(relativePath: imagePath, completion: { imageData in
            
            if let data = imageData{
                compeletion(data)
            }
            
        })
    }
}
