

import UIKit

class NetworkModel{
    
    
    func ConnectToApi(ApiURL : String){
        
        // #1 url
        let url = URL(string: ApiURL)
        
        // #2 request
        let request = URLRequest(url: url!)
        
        // #3 session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // #4 task
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // #6 exception handler
            do{
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String, Any>>
                
                
                
            }catch{
                print(error)
            }
            
        }
        
        // #5 start task
        task.resume()
    }
    
    
}
