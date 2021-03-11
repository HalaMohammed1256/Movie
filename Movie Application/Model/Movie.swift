
class Movie{
    
    var title : String
    var image : String
    var rate : Double
    var releaseYear : Int
    var genra : [String]
    
    init(title movieTitle : String, image movieImage : String, rate movieRate : Double, releaseYear movieRelease : Int, genra movieGenra : [String]) {
        
        self.title = movieTitle
        self.image = movieImage
        self.rate = movieRate
        self.releaseYear = movieRelease
        self.genra = movieGenra
    }
    
}
