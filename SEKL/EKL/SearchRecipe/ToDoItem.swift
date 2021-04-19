//
//  ToDoItem.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 19.04.21.
//  Copyright © 2021 Dennis Hasselbusch. All rights reserved.
//


import Foundation
import CoreData

enum Priority: Int {
    case low = 0
    case normal = 1
    case high = 2
}

struct ToDoItem: Identifiable {
    var id = UUID()
    var name: String = ""
    var priorityNum: Priority = .normal
    var isComplete: Bool = false
}
