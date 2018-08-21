//
//  Detale.swift
//  firtWork
//
//  Created by Александр Сенин on 21.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Detale: UIViewController {
    var user: [String: Any]!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var id: UILabel!
    
    static func storyboardInstance() -> Detale? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? Detale
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor! = UIColor.white.withAlphaComponent(0.8)
        addSwipe()
        login.text = "\(user["login"]!)"
        url.text = "URL GitHub - \(user["html_url"]!)"
        
        id.text = "ID - \(user["id"]!)"
        // Do any additional setup after loading the view.
    }
    
    func addSwipe() {
        let direction = UISwipeGestureRecognizerDirection.down
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        gesture.direction = direction
        self.view.addGestureRecognizer(gesture)
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .down {
                dismiss(animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
