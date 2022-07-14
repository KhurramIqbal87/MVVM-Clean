//
//  MovieListViewModelProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 12/12/2021.
//

import Foundation
protocol MovieListViewModelOutput: AnyObject{
    
    func didLoadItems(items: [MovieItemListViewModelType])
    func getTitle(title: String)
    func showError(message: String)
    
}

protocol NetworkCallStates: AnyObject{
    func didStartLoading()
    func didFinishLoading()
}


protocol MovieListViewModelType: ViewLifeCycle{
    //MARK: - MovieListViewModelInput
    func didSelectMovieItem(indexPath: IndexPath)
    func willScrollToIndexPath(index: Int)
    
    //MARK: - MovieListViewModelOutput

    var totalPage: Int{get}
    var currentPage: Int{get}
    
    var items: [MovieItemListViewModelType]{get}
    var pages: [MoviePage]{get}
    var delegate: MovieListViewModelOutput? { get set }
    var networkCallStates: NetworkCallStates? { get set }
    
    
}
