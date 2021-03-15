

import UIKit

class AddMovieViewController: UIViewController, SelectGendraProtocol {

    var addProtocol : AddMovieProtocol?
    var genra : [String]?
    var genraArray : [String]?
    
    var img : String = ""
    
    
    func selectGendra(gendra: [String]) {
        genraArray = gendra
        genraTextView.text = String(genraArray!.joined(separator: " | "))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieImage.layer.borderColor = UIColor.gray.cgColor
        movieImage.layer.borderWidth = 2

        
    }
    
    
    
    
    @IBAction func selectGenra(_ sender: Any) {
        
        let selectGenra = self.storyboard?.instantiateViewController(identifier: "select_gendra") as! GenraTableViewController

        selectGenra.genraDelegation = self
        selectGenra.genraArray = genra!
        

        self.present(selectGenra, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func saveNewMovie(_ sender: Any) {
        
        // image:movieImage.image!
//        addProtocol?.addMovieDelegation(movie: Movie(title: movieTitle.text!, rating: Double(movieRate.text!)!, releaseYear: Int(movieReleaseYear.text!)!, genre: genraArray!))
        
        
        
        addProtocol?.addMovieDelegation(movie: Movie(title: movieTitle.text!, imgData: movieImage.image!.pngData()!, rate: Double(movieRate.text!)!, releaseYear: Int(movieReleaseYear.text!)!, genra: genraArray!))
        
        print(img)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadImageButton(_ sender: Any) {
        
        let uploadImage = UIImagePickerController()
        uploadImage.sourceType = .photoLibrary
        uploadImage.delegate = self
        uploadImage.allowsEditing = true
        
        present(uploadImage, animated: true, completion: nil)
        
    }
    
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieReleaseYear: UITextField!
    @IBOutlet weak var movieRate: UITextField!
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var genraTextView: UITextView!
    
    
    
}


extension AddMovieViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        print(info)
        
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            movieImage.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
