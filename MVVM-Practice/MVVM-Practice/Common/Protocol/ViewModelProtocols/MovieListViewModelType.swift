//
//  MovieListViewModelProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 12/12/2021.
//

import Foundation
protocol MovieListViewModelType: ViewLifeCycle{
    //MARK: - MovieListViewModelInput
    func didSelectMovieItem(indexPath: IndexPath)
    func getItemsForNextPage()
    func willScrollToIndexPath(index: Int)
    
    //MARK: - MovieListViewModelOutput
    var didLoad : ((_ items: [MovieItemListViewModelType]?, _ indexPath: [IndexPath]?)->Void?)? {get set}
    var currentPage: Int{get}
    var totalPage: Int {get}
    var items: [MovieItemListViewModelType]{get}
    var pages: [MoviePage]{get}
    func getTitle()->String
}
