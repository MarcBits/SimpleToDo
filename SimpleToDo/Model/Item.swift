//
//  Item.swift
//  SimpleToDo
//
//  Created by Marc Cruz on 1/17/18.
//  Copyright © 2018 MarcBits. All rights reserved.
//

import Foundation

class Item: Codable {
    var title: String = ""
    var done: Bool = false
    
    init (itemTitle: String, itemCompleted: Bool) {
        self.title = itemTitle
        self.done = itemCompleted
    }
}
