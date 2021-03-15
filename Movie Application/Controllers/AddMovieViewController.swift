

import UIKit
import FloatRatingView

class AddMovieViewController: UIViewController, SelectGendraProtocol{

    var addProtocol : AddMovieProtocol?
    var genra : [String]?
    var genraArray : [String]?
    
    var img : String = ""
    let years = (1900...2100).map { Int($0) }
    
    
    func selectGendra(gendra: [String]) {
        genraArray = gendra
        genraTextView.text = String(genraArray!.joined(separator: " | "))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movieReleaseYear.delegate = self
        movieReleaseYear.dataSource = self
        
        let selectedIndex = years.firstIndex(of: Calendar.current.component(.year, from: Date()));
        movieReleaseYear.selectRow(selectedIndex!, inComponent: 0, animated: true)
        
        
        movieImage.layer.borderColor = UIColor.gray.cgColor
        movieImage.layer.borderWidth = 2

        
        
        movieRate.contentMode = UIView.ContentMode.scaleAspectFit
        movieRate.type = .floatRatings
        
        movieRate.maxRating = 10
        movieRate.editable = true
        
    }
    
    
    
    
    @IBAction func selectGenra(_ sender: Any) {
        
        let selectGenra = self.storyboard?.instantiateViewController(identifier: "select_gendra") as! GenraTableViewController

        selectGenra.genraDelegation = self
        selectGenra.genraArray = genra!
        
        self.present(selectGenra, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func saveNewMovie(_ sender: Any) {
        
        
        
        addProtocol?.addMovieDelegation(movie: Movie(title: movieTitle.text!, imgData: movieImage.image!.pngData()!, rate: Double(String(format: "%.1f", self.movieRate.rating))!, releaseYear:1990, genra: genraArray!))
        
        
        // Int(movieReleaseYear.text!)!
        
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
    @IBOutlet weak var movieReleaseYear: UIPickerView!
    @IBOutlet weak var movieRate: FloatRatingView!
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

// data picker methods
extension AddMovieViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //priorityArray count;
        
        return years.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //priorityArray[row];
        
        
        return String(years[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // priority = priorityArray[row];
        
        print(years[row])
    }
    
    
}
