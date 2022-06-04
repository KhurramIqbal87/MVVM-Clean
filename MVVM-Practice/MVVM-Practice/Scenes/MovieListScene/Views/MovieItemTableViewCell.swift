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
    
    
    var viewModel: MovieItemListViewModelType?
    
    func cofigure(viewModel: MovieItemListViewModelType) {
        self.viewModel = viewModel
        self.posterImageView?.image = UIImage(named: "placeholder-image")
        let width = self.posterImageView?.frame.width ?? 300
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self  else {return}
            self.viewModel?.getImage(width: Float(width), completion: { [weak self] imageData in
                guard let imageData = imageData, let image = UIImage(data: imageData) else{return}
                
                self?.setImage(image: image)
               
            })
            
        }
     
        self.titleLabel?.text = self.viewModel?.getTitle()
        self.ratingLabel?.text = self.viewModel?.getRatings()
        self.releaseDateLabel?.text = self.viewModel?.getFormattedReleaseDate()
    }
    
   private func setImage(image: UIImage){
       DispatchQueue.main.asyncAfter(deadline: .now()  ) {
           self.posterImageView?.image = image
       }
       
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 
    
}
