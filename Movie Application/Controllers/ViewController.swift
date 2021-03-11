//
//  ViewController.swift
//  Movie Application
//
//  Created by Hala on 12/03/2021.
//

import UIKit

class ViewController: UIViewController {

    var name : String?
    var image : String?
    var rate : Double?
    var releaseYear : Int?
    var genra : [String]?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = name!
        releaseYearLabel.text = String(releaseYear!)// as? String
        titleLabel.text = name!
        gendraTextView.text = String(genra!.joined(separator: " | "))
        rateLabel.text = String(rate!)
        
        movieImage.layer.cornerRadius = 20
        movieImage.image = UIImage(named: image!)
        
        
        
    }


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var gendraTextView: UITextView!
    
    
    
    
    
    

}

