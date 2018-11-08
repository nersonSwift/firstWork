//
//  SaveUsers.swift
//  firtWork
//
//  Created by Александр Сенин on 21.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import RealmSwift

class SaveUsers: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    
}
