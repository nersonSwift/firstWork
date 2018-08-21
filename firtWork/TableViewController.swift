//
//  TableViewController.swift
//  firtWork
//
//  Created by Александр Сенин on 21.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var users = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gitHubUsersURL = URL(string: "https://api.github.com/users?since=0")!
        let session = URLSession.shared
        session.dataTask(with: gitHubUsersURL) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                self.users = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [Any]
                
               // let s = d![0] as? [String: Any]
                
               // print(s!["login"]!)
                
            }catch{
                print(error)
            }
            
            }.resume()
        
        users = [2,4,6]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        
        let a = users[indexPath.row]
        print(a)
        
        return cell
    }

    

}
