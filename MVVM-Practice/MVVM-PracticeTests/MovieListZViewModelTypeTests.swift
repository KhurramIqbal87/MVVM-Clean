//
//  MovieListZViewModelTypeTests.swift
//  MVVM-PracticeTests
//
//  Created by Khurram Iqbal on 06/06/2022.
//

import XCTest
@testable import MVVM_Practice
class MovieListZViewModelTypeTests: XCTestCase {
    var viewModel: MovieListViewModel!
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
       
        self.viewModel = nil
    }

    func testExample() throws {
        let repository = MockMovieListRepository.init(networkManager: NetworkManager.sharedInstance)
        
        viewModel = MovieListViewModel.init(repository: repository)
        viewModel.networkCallStates = self
        viewModel.delegate = self
        viewModel.navgationDelegate = self
        viewModel.viewDidLoad()
        viewModel.viewWillAppear()
    }

    func testPerformanceExample() throws {
      
        self.measure {
          
        }
    }
    
    

}
extension MovieListZViewModelTypeTests: NetworkCallStates{
    func didStartLoading() {
        
    }
    
    func didFinishLoading() {
        
    }
    
    
}
extension MovieListZViewModelTypeTests: MovieListViewModelOutput{
    func getTitle(title: String) {
        XCTAssert(!title.isEmpty)
    }
    
    func didLoadItems(items: [MovieItemListViewModelType]) {
        XCTAssert(items.count > 0)
        self.viewModel.willScrollToIndexPath(index: self.viewModel.items.count - 1)
    }
    
    func showError(message: String) {
        XCTAssert(!message.isEmpty)
    }
}

extension MovieListZViewModelTypeTests: MovieListNavigationEvents{
    func navigateToDetail(movie: Movie) {
        XCTAssert(movie.title == viewModel.pages.first?.movies.first?.title)
    }
    
    
}
