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
    
}

protocol MovieListViewModelType: ViewLifeCycle{
    //MARK: - MovieListViewModelInput
    func didSelectMovieItem(indexPath: IndexPath)
    func getItemsForNextPage()
    func willScrollToIndexPath(index: Int)
    
    //MARK: - MovieListViewModelOutput
//    var didLoad : ((_ items: [MovieItemListViewModelType]?, _ indexPath: [IndexPath]?)->Void?)? {get set}
    
    var items: [MovieItemListViewModelType]{get}
    var pages: [MoviePage]{get}
    var delegate: MovieListViewModelOutput? { get set }
    
}
