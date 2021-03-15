import UIKit

struct Movie : Codable {
    
    var title : String
    var image : String?
    var rating : Double
    var releaseYear : Int
    var genre : [String]
    var imageData : Data?
    
    init(title movieTitle : String, image movieImage : String, rate movieRate : Double, releaseYear movieRelease : Int, genra movieGenra : [String]) {
        
        self.title = movieTitle
        self.image = movieImage
        self.rating = movieRate
        self.releaseYear = movieRelease
        self.genre = movieGenra
    }
    
    init(title movieTitle : String, imgData movieImgeData : Data, rate movieRate : Double, releaseYear movieRelease : Int, genra movieGenra : [String] ) {
        
        self.title = movieTitle
        self.rating = movieRate
        self.releaseYear = movieRelease
        self.genre = movieGenra
        self.imageData = movieImgeData
    }
    
    
}
