//
//  MovieListViewController.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 24/01/2022.
//

import Foundation
import UIKit
final class MovieListViewController: UIViewController{
    var movieListViewModel: MovieListViewModelType
    @IBOutlet private var tableView: UITableView!
    
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder) not implemented")
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Init(nibName)")
    }
    init(movieListViewModel: MovieListViewModelType){
        self.movieListViewModel = movieListViewModel
        super.init(nibName: "\(MovieListViewController.self)", bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieListViewModel.viewDidLoad()
        self.movieListViewModel.didLoad = self.itemsDidLoad(items:indexPath:)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = self.movieListViewModel.getTitle()
    }
    
    func itemsDidLoad(items: [MovieItemListViewModelType]?, indexPath: [IndexPath]?){
        guard let items = items , let indexPath = indexPath, items.count > 0 else{return}
        
        if  indexPath[0].row == 0{
            DispatchQueue.main.async {
                
                let nib = UINib(nibName: items[0].cellReusableIdentifier, bundle: nil)
                self.tableView.register(nib, forCellReuseIdentifier: items[0].cellReusableIdentifier)
                self.tableView.reloadData()
                
            }
            return
        }
        DispatchQueue.main.async {
            self.tableView.insertRows(at: indexPath, with: .none)
        }
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movieListViewModel.items.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.width * 0.377 ) + 55
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let viewModel = self.movieListViewModel.items[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellReusableIdentifier), let cellType = cell as? MovieItemTableViewCellProtocol else{ return UITableViewCell()}
 
        cellType.cofigure(viewModel: viewModel)
        return cell
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.movieListViewModel.didSelectMovieItem(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        self.movieListViewModel.willScrollToIndexPath(index: indexPath.row)
    }
}

extension MovieListViewController: StoryboardInstantiate{
    static var defaultStoryboardName: String = "MovieList"
}

