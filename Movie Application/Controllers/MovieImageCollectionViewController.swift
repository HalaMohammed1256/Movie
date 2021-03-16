

import UIKit
import CoreData
import Reachability


class MovieImageCollectionViewController: UICollectionViewController {
    
    
    var movieArr : [Movie] = [Movie]()
    var movieAddedArr = [NSManagedObject]()
    
    

    //declare this property where it won't go out of scope relative to your listener
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(movieArr)
    }



    // MARK: UICollectionViewDataSource

    

}

extension MovieImageCollectionViewController {
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
        var numberOfRows = 0
        
        if reachability.connection == .wifi || reachability.connection == .cellular{

            numberOfRows = movieArr.count

        }else{
            
            numberOfRows = movieAddedArr.count
            
        }
        
        return numberOfRows
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowImageCollectionViewCell", for: indexPath) as! ShowImageCollectionViewCell
    
        
        if reachability.connection == .unavailable{
            cell.movieImage.image =  UIImage(data: movieAddedArr[indexPath.row].value(forKey: "movieImgeData") as! Data)
            
        }else{
            cell.movieImage.sd_setImage(with: URL(string:  movieArr[indexPath.row].image!), placeholderImage: UIImage(named: "placeholder.png"))
        }
    
        return cell
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: 20, height: 20)
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
}
