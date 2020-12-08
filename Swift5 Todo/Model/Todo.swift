//
//  Todo.swift
//  Swift5 Todo
//
//  Created by 平林宏淳 on 2020/05/22.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import RealmSwift

class Todo: Object {
    
    @objc dynamic var text = ""
    @objc dynamic var selectedIndex = 0

    var done = false


}
