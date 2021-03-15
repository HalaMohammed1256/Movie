

import UIKit

class ViewController: UIViewController {

    var name : String?
    var image : String?
    var rate : Double?
    var releaseYear : Int?
    var genra : [String]?
    var imageData : Data?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = name!
        releaseYearLabel.text = String(releaseYear!)// as? String
        titleLabel.text = name!
        gendraTextView.text = String(genra!.joined(separator: " | "))
        rateLabel.text = String(rate!)
        movieImage.layer.cornerRadius = 20
        
        if imageData != nil{
            movieImage.image = UIImage(data: imageData!)
            
        }else{
            movieImage.sd_setImage(with: URL(string: image!), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        
        
        
        
    }


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var gendraTextView: UITextView!
    
    
    
    
    
    

}

