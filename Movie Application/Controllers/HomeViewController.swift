



import UIKit
import SDWebImage
import CoreData
import Reachability
import FloatRatingView



class HomeViewController: UIViewController , AddMovieProtocol{

    var movieArray = [Movie]()
    var genraArray = [String]()
    var movieAddedArray = [NSManagedObject]()
    
    
    var movieMostRatedArray = [Movie]()
    var movieAddedMostRatedArray = [NSManagedObject]()
    
    
    //declare this property where it won't go out of scope relative to your listener
    let reachability = try! Reachability()
    
    
    let context : NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        genraArray = ["Action", "Drama", "Sci-Fi", "Thriller", "Adventure", "History", "Animation", "Comedy", "Family", "Horror", "Crime"]

        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
        ConnectToApi()
        fetchFromCoreData()
        
        do{
            try reachability.startNotifier()

        }catch{
            print("sdfghjkl  dfghjk erty ")
        }
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
    
    
    
    func addMovieDelegation(movie: Movie) {
       // movieArray.append(movie)
        
        saveToCoreData(movieData: movie)
        fetchFromCoreData()
        
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
    
    
    @IBAction func addMovie(_ sender: Any) {
        
        let addMovie = self.storyboard?.instantiateViewController(identifier: "add_ movie") as! AddMovieViewController
        
        addMovie.addProtocol = self;
        
        addMovie.genra = genraArray
        
        self.present(addMovie, animated: true, completion: nil)

    }
    
    
    @IBAction func showImageCollection(_ sender: Any) {
        
        let imageCollection = self.storyboard?.instantiateViewController(identifier: "image_collection") as! MovieImageCollectionViewController
        
        if reachability.connection == .unavailable{
            
            imageCollection.movieAddedArr = movieAddedArray
            
        }else{
            
            imageCollection.movieArr = movieArray
            
        }
        
        self.navigationController?.pushViewController(imageCollection, animated: true)
        
        
    }
    
    
    func selectMovie(index : Int) {
        
        let showView = self.storyboard?.instantiateViewController(identifier: "show_data") as! ViewController
        
        
        if reachability.connection == .unavailable{
            showView.imageData = movieAddedArray[index].value(forKey: "movieImgeData") as? Data
            showView.rate = movieAddedArray[index].value(forKey: "movieRate") as? Double
            showView.name = movieAddedArray[index].value(forKey: "movieTitle") as? String
            showView.genra = movieAddedArray[index].value(forKey: "movieGenra") as? [String]
            showView.releaseYear = movieAddedArray[index].value(forKey: "movieRelease") as? Int
            
        }else{
            
            showView.image = movieArray[index].image
            showView.rate = movieArray[index].rating
            showView.name = movieArray[index].title
            showView.genra = movieArray[index].genre
            showView.releaseYear = movieArray[index].releaseYear
        }
    
        
        
        
        self.present(showView, animated: true, completion: nil)
        
    }
    
    
//    func sortArray (MovieArray array : inout [Movie], MovieAddedArray array2 : inout [NSManagedObject]){
//
//        // movie array
//        for i in 0 ..< array.count{
//            for j in i ..< array.count{
//                if array[i] > array[j]{
//                    let temp = array[i]
//                    array[i] = array[j]
//                    array[j] = temp
//                }
//            }
//        }
//
//
//        // movie added array
//        for i in 0 ..< array.count{
//            for j in i ..< array.count{
//                if array[i] > array[j]{
//                    let temp = array[i]
//                    array[i] = array[j]
//                    array[j] = temp
//                }
//            }
//        }
//
//
//    }
    


}



// core data
extension HomeViewController{
    
    
    func saveToCoreData(movieData : Movie) {
        
        let entity = NSEntityDescription.entity(forEntityName: "MovieData", in: context)
        let movie = NSManagedObject(entity: entity!, insertInto: context)
        
        movie.setValue(movieData.title, forKey: "movieTitle")
        movie.setValue(movieData.rating, forKey: "movieRate")
        movie.setValue(movieData.releaseYear, forKey: "movieRelease")
        
        
        if movieData.image != nil{
            movie.setValue(movieData.image, forKey: "movieImage")
        }else{
            movie.setValue(movieData.imageData, forKey: "movieImgeData")
        }
        
        movie.setValue(movieData.genre, forKey: "movieGenra")
        
        
        do{
            try context.save()
            
            print("data saved")
            
        }catch let error as NSError{
            print(error)
        }
        
    }
    
    
    func fetchFromCoreData(){
        
        let fetchRequest = NSFetchRequest<MovieData>(entityName: "MovieData") // select * from MovieData
        
        do{
            movieAddedArray = try context.fetch(fetchRequest)
            movieAddedMostRatedArray = movieAddedArray
            movieAddedMostRatedArray.sort(by: { ($0.value(forKey: "movieRate") as! Double) > ($1.value(forKey: "movieRate") as! Double) })
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.collectionView.reloadData()
            }
            
        }catch let error as NSError{
            print(error)
        }
        
        
    }
    
        
}


// connect to api
extension HomeViewController{
    
    func ConnectToApi() {

        // #1 url
        let url = URL(string: "https://api.androidhive.info/json/movies.json")

        // #2 request
        let request = URLRequest(url: url!)

        // #3 session
        let session = URLSession(configuration: URLSessionConfiguration.default)

        // #4 task
        let task = session.dataTask(with: request) { [self] (data, response, error) in

            // #6 exception handler
            do{

                let decoder = JSONDecoder()
                let jesonArray = try decoder.decode([Movie].self, from: data!)
                self.movieArray = jesonArray
                
                movieMostRatedArray = movieArray
                movieMostRatedArray.sort(by: { $0.rating > $1.rating })

                DispatchQueue.main.async {

                    self.tableView.reloadData()
                    self.collectionView.reloadData()

                }

            }catch{
                print(error)
            }

        }

        // #5 start task
        task.resume()
    }




}




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


// collection View
extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfRows = 0
        
        if reachability.connection == .wifi || reachability.connection == .cellular{

            numberOfRows = movieMostRatedArray.count

        }else{

            numberOfRows = movieAddedMostRatedArray.count
            
        }
        
        return numberOfRows
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.imageCollection.layer.cornerRadius = 20
        
        if reachability.connection == .unavailable{
            cell.imageCollection.image =  UIImage(data: movieAddedMostRatedArray[indexPath.row].value(forKey: "movieImgeData") as! Data)
            
        }else{
            cell.imageCollection.sd_setImage(with: URL(string:  movieMostRatedArray[indexPath.row].image!), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
    
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectMovie(index: indexPath.row)

    }
    
    
    
    
}
