import UIKit

class Movie{
    
    var title : String
    var image : UIImage
    var rate : Double
    var releaseYear : Int
    var genra : [String]
    
    init(title movieTitle : String, image movieImage : UIImage, rate movieRate : Double, releaseYear movieRelease : Int, genra movieGenra : [String]) {
        
        self.title = movieTitle
        self.image = movieImage
        self.rate = movieRate
        self.releaseYear = movieRelease
        self.genra = movieGenra
    }
    
}
