//
//  MovieItemTableViewCell.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 27/02/2022.
//

import UIKit

class MovieItemTableViewCell: UITableViewCell, MovieItemTableViewCellProtocol {
   
    
    var viewModel: MovieItemListViewModelProtocol?
    
    func cofigure(viewModel: MovieItemListViewModelProtocol) {
        self.viewModel = viewModel
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 
    
}
