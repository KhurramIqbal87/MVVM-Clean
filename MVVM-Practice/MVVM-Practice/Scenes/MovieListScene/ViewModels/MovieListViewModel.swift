//
//  DefaultMovieListViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

class MovieListViewModel: MovieListViewModelType{
    
    private(set) var currentPage: Int = 1
    private(set) var totalPage: Int = 0
    
    var items: [MovieItemListViewModelType] = []
   
    var pages: [MoviePage] = []
    private let repository: MovieListImageRepositoryType
 
    
    weak  var navgationDelegate: MovieListNavigationEvents?
    weak var delegate: MovieListViewModelOutput?
    
    private init(){
        fatalError("Init() not implemented")
    }
//    MARK: ViewModel Setup
    init( repository: MovieListImageRepositoryType ){
        self.repository = repository
    }
    
    //MARK: - View Life Cycle
    func viewDidLoad() {
        self.getItemsForNextPage()
    }
    
    func viewWillAppear() {
        self.delegate?.getTitle(title: "Movies")
    }
    func viewWillDisappear() {
      
    }
    //MARK: - TableView delegates
    func didSelectMovieItem(indexPath: IndexPath) {
       let movies = self.pages.flatMap { page in
            return page.movies
        }
        let movie =  movies[indexPath.row]
        self.navgationDelegate?.navigateToDetail(movie: movie)
    }
    
    func getItemsForNextPage() {
        self.repository.getMovies(forIndex: self.currentPage, completion: { [weak self]  moviePage in
            guard let self = self , let moviePage = moviePage else {return}
            self.pages.append(moviePage)
            self.totalPage = moviePage.totalPage
            self.makeViewModels(movies: moviePage.movies)
           
        })
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
//        self.didLoad?(movieViewModels, indexPaths)
        self.delegate?.didLoadItems(items: movieViewModels)
        
    }
    private func updateStates(movieViewModels: [MovieItemListViewModel]){
        self.items.append(contentsOf: movieViewModels)
        self.currentPage += 1
    }
    func willScrollToIndexPath(index: Int) {
        if self.items.count  - 1 ==  index && currentPage < self.totalPage{
            self.getItemsForNextPage()
        }
    }
   
}
