//
//  MovieListViewModelTdd.swift
//  MVVM-PracticeTests
//
//  Created by Khurram Iqbal on 01/12/2021.
//

//user input tdd test
//viewdidload -> viewModel  -> viewDidLoad()

import XCTest

class MovieListViewModelTDD: XCTestCase{
    
    override func tearDownWithError() throws {
        
    }
    override func setUpWithError() throws {
        
    }
   
    
    func testPerformace(){
        measure {
            
        }
    }
   
    func test_viewDidLoad_loadInitialData(){
        let viewModel = DIMockContainer().resolve(MovieViewModel.self)
        viewModel.viewDidLoad()
        viewModel.didLoad = { movieItemListViewModel in
            XCTAssertTrue(viewModel.items.count == movieItemListViewModel.count )
        }
    }
    
    func test_check_currentPage_count(){
        //isolation
        let viewModel = DIMockContainer().resolve(MovieViewModel.self)
        viewModel.viewDidLoad()
        viewModel.update = { movieItemListViewModel in
            XCTAssertTrue(movieItemListViewModel.currentPage == 1)
        }
        
    }
    
    func test_totalPage_greaterOrEqualto_currentPage(){
        let viewModel = DIMockContainer().resolve(MovieViewModel.self)
        viewModel.viewDidLoad()
        viewModel.update = { movieItemListViewModel in
            XCTAssertTrue(viewModel.totalPage >= viewModel.currentPage )
        }
    }
    func test_clickOn_tableviewRow(indexPath: IndexPath){
        let viewModel = DIMockContainer().resolve(MovieViewModel.self)
        viewModel.viewDidLoad()
        viewModel.showDetailScreen(indexPath)
        assert(viewModel.coordinator.childCoordinator.last as? MovieDetailCoordinator ?? false)
    }
}





//list model -> detailViewModel

