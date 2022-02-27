//
//  MovieListViewModelProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 12/12/2021.
//

import Foundation
protocol MovieListViewModelProtocol: ViewLifeCycleProtocol{
    //MARK: - MovieListViewModelInput
    func didSelectMovieItem(indexPath: IndexPath)
    func getItemsForNextPage()
    
    //MARK: - MovieListViewModelOutput
    var didLoad : ((_ items: [MovieItemListViewModelProtocol]?, _ indexPath: [IndexPath]?)->Void?)? {get set}
    var currentPage: Int{get}
    var totalPage: Int {get}
    var items: [MovieItemListViewModelProtocol]{get}
    var pages: [MoviePage]{get}
}
