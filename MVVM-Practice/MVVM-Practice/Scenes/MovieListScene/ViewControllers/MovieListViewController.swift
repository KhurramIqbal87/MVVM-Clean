//
//  MovieListViewController.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 24/01/2022.
//

import Foundation
import UIKit
class MovieListViewController: UIViewController{
    var movieListViewModel: MovieListViewModelProtocol?
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieListViewModel?.viewDidLoad()
        self.movieListViewModel?.didLoad = self.itemsDidLoad(items:indexPath:)
    }
    
    func setupViewModel(viewModel: MovieListViewModelProtocol){
        self.movieListViewModel = viewModel
    }
    
    func itemsDidLoad(items: [MovieItemListViewModelProtocol]?, indexPath: [IndexPath]?){
        
       let indexPath = indexPath ?? []
        
        self.tableView.insertRows(at: indexPath, with: .none)
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movieListViewModel?.items.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let viewModel = self.movieListViewModel?.items[indexPath.row],   let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellReusableIdentifier), let cellType = cell as? MovieItemTableViewCellProtocol else{ return UITableViewCell()}
 
        cellType.cofigure(viewModel: viewModel)
        return cell
        
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.movieListViewModel?.didSelectMovieItem(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.movieListViewModel?.items.count ?? 0 - 1 == indexPath.row{
            self.movieListViewModel?.getItemsForNextPage()
        }
    }
}

extension MovieListViewController: StoryboardInstantiate{}

