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
 
    weak var networkCallStates: NetworkCallStates?
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
    
    private func getItemsForNextPage() {
        self.networkCallStates?.didStartLoading()
        self.repository.getMovies(forIndex: self.currentPage, completion: { [weak self]  (moviePage, error) in
            self?.networkCallStates?.didFinishLoading()
            if let error = error{
                self?.showErrorMessage(error: error)
                return
            }
            guard let self = self , let moviePage = moviePage else {return}
            self.pages.append(moviePage)
            self.totalPage = moviePage.totalPage
            self.makeViewModels(movies: moviePage.movies)
            
           
        })
    }
    
    private func showErrorMessage(error: NetworkError){
        self.delegate?.showError(message: error.getErrorMessage())
    }
    
    private func makeViewModels(movies: [Movie]){
        let movieViewModels = MovieItemListViewModel.convertModelsToViewModels(movies: movies)
       
        self.updateStates(movieViewModels: movieViewModels)
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
