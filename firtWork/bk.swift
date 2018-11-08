//
//  bk.swift
//  firtWork
//
//  Created by Александр Сенин on 05/10/2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import Foundation
import RealmSwift

class test: Object {
    var type = ""
    var cla: ret{
        set(a){
            type = "ret"
        }
        get{
            return ret()
        }
    }
}
