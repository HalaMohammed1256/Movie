//
//  MovieTableViewController.swift
//  Movie Application
//
//  Created by Hala on 12/03/2021.
//

import UIKit

class MovieTableViewController: UITableViewController, AddMovie{

    var movieArray : [Movie] = []
    var genraArray : [String] = []
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
        genraArray = ["Science fiction", "adventure", "family", "ambiguity", "action", "drama", "Horror", "Musical"]
        
        movieArray.append(Movie(title: "Harry Potter and the Order of the Phoenix", image: UIImage(named: "harry")!, rate: 5, releaseYear: 2007, genra: [genraArray[0], genraArray[1], genraArray[2], genraArray[3], genraArray[4]]))
        
        movieArray.append(Movie(title: "Mulan", image: UIImage(named:"mulan")!, rate: 4, releaseYear: 2020, genra: [genraArray[4], genraArray[5], genraArray[2], genraArray[1]]))
        
        movieArray.append(Movie(title: "The Darkest Mind", image: UIImage(named:"darkest")!, rate: 4.5, releaseYear: 2018, genra: [genraArray[0], genraArray[1], genraArray[2], genraArray[3], genraArray[4]]))
        
        movieArray.append(Movie(title: "Bird Box", image: UIImage(named:"bird")!, rate: 3.9, releaseYear: 2018, genra: [genraArray[0], genraArray[5], genraArray[6]]))
        
        movieArray.append(Movie(title: "Frozen II", image: UIImage(named:"frozen")!, rate: 5, releaseYear: 2020, genra: [genraArray[5], genraArray[1], genraArray[2], genraArray[7]]))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func addMovieDelegation(movie: Movie) {
        movieArray.append(movie)
        
        self.tableView.reloadData()
    }
    
    
    @IBAction func addMovie(_ sender: Any) {
        
        let addMovie = self.storyboard?.instantiateViewController(identifier: "add_ movie") as! AddMovieViewController
        
        addMovie.addProtocol = self;
        
        addMovie.genra = genraArray
        
        self.present(addMovie, animated: true, completion: nil)

    }
    
}


// Table view data source
extension MovieTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movieArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell

        cell.movieName.text = movieArray[indexPath.row].title
        cell.movieImage.image = movieArray[indexPath.row].image
        cell.movieGenra.text = movieArray[indexPath.row].genra.joined(separator: " | ")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let showView = self.storyboard?.instantiateViewController(identifier: "show_data") as! ViewController
        
        showView.name = movieArray[indexPath.row].title
        showView.genra = movieArray[indexPath.row].genra
        showView.image = movieArray[indexPath.row].image
        showView.rate = movieArray[indexPath.row].rate
        showView.releaseYear = movieArray[indexPath.row].releaseYear
        
        
        //self.navigationController?.pushViewController(showView, animated: true)
        
        self.present(showView, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    


    
}
