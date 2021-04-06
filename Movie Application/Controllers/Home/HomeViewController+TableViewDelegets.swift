//
//  HomeViewController+TableViewDelegets.swift
//  Movie Application
//
//  Created by Hala on 18/03/2021.
//

import Foundation
import UIKit


// table View
extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows = 0
        
        if reachability.connection == .wifi || reachability.connection == .cellular{

            numberOfRows = movieArray.count

        }else{

            numberOfRows = movieAddedArray.count
            
        }
        
        return numberOfRows
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell

        cell.movieImage.layer.cornerRadius = 20
        
        cell.ratingView.contentMode = UIView.ContentMode.scaleAspectFit
        cell.ratingView.type = .floatRatings
        
        
        cell.imageView?.startAnimating()
        cell.ratingView.maxRating = 10
        cell.ratingView.editable = false
        
        if reachability.connection == .wifi || reachability.connection == .cellular{


            cell.ratingView.rating = movieArray[indexPath.row].rating

            cell.movieName.text = movieArray[indexPath.row].title
            if movieArray[indexPath.row].imageData != nil{
                        // convert data to image

                cell.movieImage.image = UIImage(data: movieArray[indexPath.row].imageData!)

            }else{

                cell.movieImage.sd_setImage(with: URL(string: movieArray[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            }
            cell.movieGenra.text = movieArray[indexPath.row].genre.joined(separator: " | ")

        }else{
            
            cell.movieName.text = movieAddedArray[indexPath.row].value(forKey: "movieTitle") as? String
            cell.movieImage.image = UIImage(data: movieAddedArray[indexPath.row].value(forKey: "movieImgeData") as! Data)
            cell.movieGenra.text = (movieAddedArray[indexPath.row].value(forKey: "movieGenra") as! [String]).joined(separator: " | ")
            cell.ratingView.rating = movieAddedArray[indexPath.row].value(forKey: "movieRate") as! Double
        }
        

        
        //movieTitle    movieRate   movieRelease    movieImgeData   movieGenra

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectMovie(index: indexPath.row)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
                
                
                if reachability.connection == .unavailable{
                    
                    //remove from core data
                    context.delete(movieAddedArray[indexPath.row])
                    
                    
                    // remove from rated
                    if movieAddedMostRatedArray.contains(movieAddedArray[indexPath.row]) == true {
                        let index = movieAddedMostRatedArray.firstIndex(of: movieAddedArray[indexPath.row])
                        movieAddedMostRatedArray.remove(at: index!)
                    }
                    
                    
                    
                    // remove from array
                    movieAddedArray.remove(at: indexPath.row)
                    
                    
                    // save changes
                    do{
                        
                        try context.save()
                        print("data removed")
                        
                        
                    }catch let error as NSError{
                        print(error)
                    }
                    
                    // remove from table
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    //collectionView.deleteItems(at: [indexPath])
                    collectionView.reloadData()
                }
                

            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    
    }
    
}
