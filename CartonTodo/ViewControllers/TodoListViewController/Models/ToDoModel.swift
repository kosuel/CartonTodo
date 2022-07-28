//
//  ToDoModel.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import Foundation

/// single todo item
struct TodoItem: Codable{
    var userId: String
    var id: String
    var title: String
    var completed: Bool
}
