//
//  MovieTableViewCell.swift
//  Movie Application
//
//  Created by Hala on 12/03/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var movieGenra: UILabel!
    
    @IBOutlet weak var movieRateView: UIView!
    

}
