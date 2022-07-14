//
//  MovieListViewController.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 24/01/2022.
//

import Foundation
import UIKit
final class MovieListViewController: UIViewController{
    let viewModel: MovieListViewModelType
    @IBOutlet private var tableView: UITableView!
    
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder) not implemented")
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Init(nibName)")
    }
    init( movieListViewModel: inout MovieListViewModelType){
        
        self.viewModel = movieListViewModel
        
        super.init(nibName: "\(MovieListViewController.self)", bundle: nil)
        movieListViewModel.delegate = self
        movieListViewModel.networkCallStates = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.viewWillAppear()
        
    }
    
    
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.width * 0.377 ) + 55
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let viewModel = self.viewModel.items[indexPath.row]
        let cell = self.getDequeCell(indexPath: indexPath)
        guard let cellType = cell as? MovieItemTableViewCellProtocol else{return cell}
 
        cellType.cofigure(viewModel: viewModel)
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectMovieItem(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        self.viewModel.willScrollToIndexPath(index: indexPath.row)
    }
    
    func getDequeCell(indexPath: IndexPath)->UITableViewCell{
        let viewModel = self.viewModel.items[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellReusableIdentifier), let _ = cell as? MovieItemTableViewCellProtocol {
            return cell
        }
        
        let nib = UINib.init(nibName: viewModel.cellReusableIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: viewModel.cellReusableIdentifier)
       
        if let cell =   tableView.dequeueReusableCell(withIdentifier: viewModel.cellReusableIdentifier),let _ = cell as? MovieItemTableViewCellProtocol  {
            return cell
        }
      
        return UITableViewCell()
    }
}

extension MovieListViewController: StoryboardInstantiate{
    static var defaultStoryboardName: String = "MovieList"
}

extension MovieListViewController: MovieListViewModelOutput{
    func getTitle(title: String) {
        self.title = title
    }
    func didLoadItems(items: [MovieItemListViewModelType]) {
        
       
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    func showError(message: String) {
        self.showError(title: "Error", message: message)
    }
}
extension MovieListViewController: NetworkCallStates{
    func didStartLoading() {
        
        self.showLoader()
    }
    func didFinishLoading() {
        self.hideLoader()
    }
}
