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
        
        movieArray.append(Movie(title: "Harry Potter and the Order of the Phoenix", image: "harry", rate: 5, releaseYear: 2007, genra: [genraArray[0], genraArray[1], genraArray[2], genraArray[3], genraArray[4]]))
        
        movieArray.append(Movie(title: "Mulan", image: "mulan", rate: 4, releaseYear: 2020, genra: [genraArray[4], genraArray[5], genraArray[2], genraArray[1]]))
        
        movieArray.append(Movie(title: "The Darkest Mind", image: "darkest", rate: 4.5, releaseYear: 2018, genra: [genraArray[0], genraArray[1], genraArray[2], genraArray[3], genraArray[4]]))
        
        movieArray.append(Movie(title: "Bird Box", image: "bird", rate: 3.9, releaseYear: 2018, genra: [genraArray[0], genraArray[5], genraArray[6]]))
        
        movieArray.append(Movie(title: "Frozen II", image: "frozen", rate: 5, releaseYear: 2020, genra: [genraArray[5], genraArray[1], genraArray[2], genraArray[7]]))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    

//    func addMovieDelegation(title: String, image: String, rate: Double, releaseYear: Int, genra: [String]) {
//
//        movieArray.append()
//    title : String, image : String, rate : Double, releaseYear : Int, genra : [String]
//
//    }
    
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
        cell.movieImage.image = UIImage(named: movieArray[indexPath.row].image)
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
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
