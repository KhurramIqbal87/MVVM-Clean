//
//  DefaultMovieListViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

class DefaultMovieListViewModel: MovieListViewModelProtocol{
    var currentPage: Int = 0
    var totalPage: Int = 0
    
    var items: [MovieItemListViewModelProtocol] = []
    
    var pages: [MoviePage] = []
    private var repository: MovieListImageRepositoryProtocol?
    private var coordinator: Coordinator?
    var didLoad: (([MovieItemListViewModelProtocol]?, _ indexPath: [IndexPath]?) -> Void? )?
//    MARK: ViewModel Setup
    init( repository: MovieListRepositoryProtocol  ){
        self.repository = repository
    }
    
    func setCoordinator(coordinator: Coordinator){
        self.coordinator = coordinator
    }
    //MARK: - View Life Cycle
    func viewDidLoad() {
        self.getItemsForNextPage()
    }
   
    func viewWillDisappear() {
        if let coordinator = self.coordinator{
            coordinator.childDidFinish(coordinator: coordinator)
        }
    }
    //MARK: - TableView delegates
    func didSelectMovieItem(indexPath: IndexPath) {
       let movies = self.pages.flatMap { page in
            return page.movies
        }
        let movie =  movies[indexPath.row]
        
        
        
    }
    
    func getItemsForNextPage() {
        self.repository?.getMovies(forIndex: self.currentPage, completion: { [weak self]  moviePage in
            guard let self = self , let moviePage = moviePage else {return}
            self.pages.append(moviePage)
            let movieViewModels = DefaultMovieItemListViewModel.convertModelsToViewModels(movies: moviePage.movies)
            self.items.append(contentsOf: movieViewModels)
            var indexPaths: [IndexPath] = []
            var count = self.items.count
            for _ in moviePage.movies{
                let indexPath = IndexPath(row: count, section: 0)
                indexPaths.append(indexPath)
                count += 1
            }
            self.didLoad?(movieViewModels, indexPaths)
        })
    }
    
   
}
