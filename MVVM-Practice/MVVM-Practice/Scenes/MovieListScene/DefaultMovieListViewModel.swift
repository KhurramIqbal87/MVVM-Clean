//
//  DefaultMovieListViewModel.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 26/12/2021.
//

import Foundation

class MovieListViewModel: MovieListViewModelProtocol{
    var didLoad: (([MovieItemListViewModelProtocol]?) -> Void?)?
    
    func viewDidLoad() {
        
    }
    
    func didSelectMovieItem(indexPath: IndexPath) {
        
    }
    
    func getItemsForNextPage() {
        
    }
    
    var currentPage: Int = 0
    var totalPage: Int = 0
    
    var items: [MovieItemListViewModelProtocol] = []
    
    var pages: [MoviePage] = []
}
