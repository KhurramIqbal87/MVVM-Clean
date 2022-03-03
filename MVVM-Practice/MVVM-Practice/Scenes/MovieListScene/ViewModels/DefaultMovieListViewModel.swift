//
//  DefaultMovieListViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

class DefaultMovieListViewModel: MovieListViewModelProtocol{
    var currentPage: Int = 1
    var totalPage: Int = 0
    
    var items: [MovieItemListViewModelProtocol] = []
    
    var pages: [MoviePage] = []
    private var repository: MovieListImageRepositoryProtocol?
    private var coordinator: MovieListCoordinatorProtocol?
    var didLoad: (([MovieItemListViewModelProtocol]?, _ indexPath: [IndexPath]?) -> Void? )?
//    MARK: ViewModel Setup
    init( repository: MovieListImageRepositoryProtocol, coordinator: MovieListCoordinatorProtocol ){
        self.repository = repository
        self.coordinator = coordinator 
    }
    
    func setCoordinator(coordinator: MovieListCoordinatorProtocol){
        self.coordinator = coordinator
    }
    //MARK: - View Life Cycle
    func viewDidLoad() {
        self.getItemsForNextPage()
    }
   
    func viewWillDisappear() {
        if let coordinator = self.coordinator{
            coordinator.childDidFinish(coordinator: coordinator)
            self.coordinator = nil
        }
    }
    //MARK: - TableView delegates
    func didSelectMovieItem(indexPath: IndexPath) {
       let movies = self.pages.flatMap { page in
            return page.movies
        }
        let movie =  movies[indexPath.row]
        self.coordinator?.navigateToDetailController(movie: movie)
        
        
    }
    
    func getItemsForNextPage() {
        self.repository?.getMovies(forIndex: self.currentPage, completion: { [weak self]  moviePage in
            guard let self = self , let moviePage = moviePage else {return}
            self.pages.append(moviePage)
            self.makeViewModels(movies: moviePage.movies)
           
        })
    }
    private func makeViewModels(movies: [Movie]){
        let movieViewModels = DefaultMovieItemListViewModel.convertModelsToViewModels(movies: movies)
        var indexPaths: [IndexPath] = []
        var count = self.items.count
        for _ in movies{
            let indexPath = IndexPath(row: count, section: 0)
            indexPaths.append(indexPath)
            count += 1
        }
        self.updateStates(movieViewModels: movieViewModels)
        self.didLoad?(movieViewModels, indexPaths)
        
    }
    private func updateStates(movieViewModels: [DefaultMovieItemListViewModel]){
        self.items.append(contentsOf: movieViewModels)
        self.currentPage += 1
    }
   
}
