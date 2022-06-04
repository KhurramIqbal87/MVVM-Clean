//
//  DefaultMovieListViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

class MovieListViewModel: MovieListViewModelType{
    var currentPage: Int = 1
    var totalPage: Int = 0
    
    var items: [MovieItemListViewModelType] = []
    weak  var movieListNavigationDelegate: MovieListNavigationEvents?
    var pages: [MoviePage] = []
    private var repository: MovieListImageRepositoryType?
    var didLoad: (([MovieItemListViewModelType]?, _ indexPath: [IndexPath]?) -> Void? )?
//    MARK: ViewModel Setup
    init( repository: MovieListImageRepositoryType ){
        self.repository = repository
    }
    
    
    //MARK: - View Life Cycle
    func viewDidLoad() {
        self.getItemsForNextPage()
    }
    
   
    func viewWillDisappear() {
      
    }
    //MARK: - TableView delegates
    func didSelectMovieItem(indexPath: IndexPath) {
       let movies = self.pages.flatMap { page in
            return page.movies
        }
        let movie =  movies[indexPath.row]
        self.movieListNavigationDelegate?.navigateToDetail(movie: movie)
        
        
    }
    
    func getItemsForNextPage() {
        self.repository?.getMovies(forIndex: self.currentPage, completion: { [weak self]  moviePage in
            guard let self = self , let moviePage = moviePage else {return}
            self.pages.append(moviePage)
            self.makeViewModels(movies: moviePage.movies)
           
        })
    }
    func getTitle() -> String {
        return "Movies"
    }
    private func makeViewModels(movies: [Movie]){
        let movieViewModels = MovieItemListViewModel.convertModelsToViewModels(movies: movies)
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
    private func updateStates(movieViewModels: [MovieItemListViewModel]){
        self.items.append(contentsOf: movieViewModels)
        self.currentPage += 1
    }
    func willScrollToIndexPath(index: Int) {
        if self.items.count  - 1 ==  index {
            self.getItemsForNextPage()
        }
    }
   
}
