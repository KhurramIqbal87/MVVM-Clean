//
//  MovieItemTableViewCell.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 27/02/2022.
//

import UIKit

class MovieItemTableViewCell: UITableViewCell, MovieItemTableViewCellProtocol {
    @IBOutlet private var posterImageView: UIImageView?
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var releaseDateLabel: UILabel?
    @IBOutlet private var ratingLabel: UILabel?
    
    var viewModel: MovieItemListViewModelProtocol?
    
    func cofigure(viewModel: MovieItemListViewModelProtocol) {
        self.viewModel = viewModel
        self.viewModel?.getImage(completion: { [weak posterImageView] imageData in
            guard let imageData = imageData, let image = UIImage(data: imageData) else{return}
            DispatchQueue.main.async {
                posterImageView?.image = image
            }
           
        })
        self.titleLabel?.text = self.viewModel?.title
        self.ratingLabel?.text = self.viewModel?.getRatings()
        self.releaseDateLabel?.text = self.viewModel?.releaseDate
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 
    
}
