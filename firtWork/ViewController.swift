//
//  ViewController.swift
//  firtWork
//
//  Created by Александр Сенин on 20.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myTable = UITableView()
    var users = [Any]()
    
    var lastCell = 0
    var idLastUser = 0
    
    var getPack = true
    var getError = false
    
    var realm = try! Realm()
    var results: Results<SaveUsers>!
    var resulte: Results<test>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        results = realm.objects(SaveUsers.self)
        resulte = realm.objects(test.self)
        
        if results.count > 0{
            loadUsers()
        }

        if users.count < 15{
            takeUsers()
        }
        
        self.createTable()
    }
    
    
    //MARK: - createTable
    func createTable(){
        self.myTable = UITableView(frame: self.view.bounds, style: .plain)
        self.myTable.delegate = self
        self.myTable.dataSource = self
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.myTable)
    }
    
    
    //MARK: - take Users from git hub
    func takeUsers(){
        
        let gitHubUsersURL = URL(string: "https://api.github.com/users?since=\(idLastUser)")!
        let session = URLSession.shared
        session.dataTask(with: gitHubUsersURL) { (data, response, error) in
            
            guard let data = data else {
                self.getError = true
                return
            }
            guard let response = response else {
                self.getError = true
                return
            }
            do{
                if let packUsers = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [Any]{
                    self.users.append(contentsOf: packUsers)
                    self.getPack = true
                    self.getError = false
                }else{
                    self.getError = true
                    print(response)
                    
                }
            }catch{
                self.getError = true
                print(error)
               
            }
            DispatchQueue.main.async {
                self.myTable.reloadData()
                print("Show image data")
            }
        }.resume()
        
        
        self.saveUsers()
    }
    
    
    //MARK: - load and save Users
    func loadUsers(){
        for i in 0..<results.count{
            let id = results[i].id
            let name = results[i].name
            let url = results[i].url
            
            users.append(["id": id, "login": name, "html_url": url])
        }
        idLastUser = results[results.count - 1].id
        lastCell = results.count
    }
    
    func saveUsers(){
        for i in lastCell..<users.count{
            let saveUser = SaveUsers()
            let user = users[i] as! [String : Any]
            
            saveUser.id = user["id"]! as! Int
            saveUser.name = user["login"]! as! String
            saveUser.url = user["html_url"]! as! String
            
            try! realm.write {
                realm.add([saveUser])
            }
        }
        //let a = test()
        //a.cla = ret()
       
    }
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if users.count > 0{
            lastCell = users.count
            let element = users[users.count-1] as! [String : Any]
            idLastUser = element["id"] as! Int
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let call = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let element = users[indexPath.row] as! [String : Any]
        call.textLabel?.text = "\(indexPath.row) : \(element["login"]!)"
        
        call.accessoryType = .detailButton
       
        if (indexPath.row == users.count - 5) && getPack{
            getPack = false
            takeUsers()
            //myTable.reloadData()
        }
        return call
    }
    //MARK: - UITableViewDataDelegat
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let nextViewController = Detale.storyboardInstance() {
            nextViewController.modalPresentationStyle = .custom
            nextViewController.user = users[indexPath.row] as? [String : Any]
            
            self.present(nextViewController, animated: true, completion: nil)
        }
        
    }
    
}

