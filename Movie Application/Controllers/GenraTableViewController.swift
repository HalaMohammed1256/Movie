//
//  GenraTableViewController.swift
//  Movie Application
//
//  Created by Hala on 12/03/2021.
//

import UIKit

class GenraTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectedItems = [String]()
    
    var genraDelegation : SelectGendraDelegation?
    var genraArray : [String] = [""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.genraTableView.tableFooterView = UIView.init(frame: CGRect.zero)

    }
    
    @IBOutlet weak var genraTableView: UITableView!
    @IBOutlet weak var genraSave: UIButton!
    @IBAction func save(_ sender: Any) {
        
        genraDelegation?.selectGendra(gendra: selectedItems)
        self.dismiss(animated: true, completion: nil)
        
//        print(selectedItems)
        
    }
    
    // table method
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genraArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        
        cell.textLabel?.text = genraArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
                        
            let index : Int = selectedItems.firstIndex(of: genraArray[indexPath.row])!
            
            selectedItems.remove(at: index)
        
            
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
            selectedItems.append(genraArray[indexPath.row])
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    


     

    
    

}
