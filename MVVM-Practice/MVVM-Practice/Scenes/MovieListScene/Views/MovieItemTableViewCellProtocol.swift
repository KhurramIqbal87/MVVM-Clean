//
//  MovieItemTableViewCellProtocol.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 27/02/2022.
//

import UIKit

protocol MovieItemTableViewCellProtocol{
    
    var viewModel: MovieItemListViewModelProtocol? { get }
    func cofigure(viewModel: MovieItemListViewModelProtocol)
    
}


