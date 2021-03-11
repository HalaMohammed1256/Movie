//
//  AddMovieViewController.swift
//  Movie Application
//
//  Created by Hala on 12/03/2021.
//

import UIKit

class AddMovieViewController: UIViewController, SelectGendraDelegation {

    var addProtocol : AddMovie?
    var genra : [String]?
    var genraArray : [String]?
    
    
    func selectGendra(gendra: [String]) {
        genraArray = gendra
        genraTextView.text = String(genraArray!.joined(separator: " | "))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
          
//        saveDesign.layer.cornerRadius = 20
//        saveDesign.layer.borderColor = UIColor.black.cgColor
//        saveDesign.layer.borderWidth = 2
        
        movieImage.layer.borderColor = UIColor.black.cgColor
        movieImage.layer.borderWidth = 2
        

    }
    
    
    @IBAction func test(_ sender: Any) {
        
        let selectGenra = self.storyboard?.instantiateViewController(identifier: "select_gendra") as! GenraTableViewController
        
        selectGenra.genraDelegation = self
        selectGenra.genraArray = genra!
        
        self.present(selectGenra, animated: true, completion: nil)
        
    }
    @IBAction func saveNewMovie(_ sender: Any) {
        
//        addProtocol?.addMovieDelegation(movie: Movie(title: "Harry Potter and the Order of the Phoenix", image: "harry", rate: 5, releaseYear: 2007, genra: ["hh", "mm", "ll"]))
        
        
        //////////
        
        addProtocol?.addMovieDelegation(movie: Movie(title: movieTitle.text!, image: "harry", rate: Double(movieRate.text!)!, releaseYear: Int(movieReleaseYear.text!)!, genra: genraArray!))
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieReleaseYear: UITextField!
    @IBOutlet weak var movieRate: UITextField!
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var selectGenra: UIButton!
    @IBOutlet weak var genraTextView: UITextView!
    
    
    
    
    
    
    
}
