//
//  ToDoListViewModel.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import Foundation
import UIKit

struct TodoListViewModel{
    private var todos: [TodoItem]
    
    var numOfItems: Int{
        todos.count
    }
    
    func cellViewModel(at: Int) -> TodoListCellViewModel{
        let todoItem = todos[at]
        
        return TodoListCellViewModel(title: todoItem.title, isCompleted: todoItem.completed)
    }
    
    init(todos: [TodoItem]) {
        self.todos = todos
    }
}

struct TodoListCellViewModel{
    var title: String
    var isCompleted: Bool
    
    var image: UIImage{
        UIImage(systemName: isCompleted ? "checkmark.circle" : "circle")!
    }
}
