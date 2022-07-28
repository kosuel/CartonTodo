//
//  ToDoModel+Dummy.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import Foundation

extension TodoListViewModel{
    
    static var dummyViewModel: Self {
        return TodoListViewModel(todos: [TodoItem(userId: "1", id: "1", title: "buy an apple", completed: false),
                                         TodoItem(userId: "1", id: "2", title: "wash my car", completed: true),
                                         TodoItem(userId: "1", id: "3", title: "call mom", completed: true),
                                         TodoItem(userId: "1", id: "4", title: "study swift", completed: false),
                                         TodoItem(userId: "1", id: "5", title: "laundary", completed: false),
                                         TodoItem(userId: "1", id: "6", title: "go to coles", completed: false),
                                         TodoItem(userId: "1", id: "7", title: "job interview", completed: false),
                                         TodoItem(userId: "1", id: "8", title: "check the oil", completed: false)] )
    }
}
