//
//  ToDoListViewModel.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import Foundation
import Combine

/// view model for TodoListViewController
class TodoListViewModel{
    private var todos: [TodoItem]
    
    private var publisher = PassthroughSubject<Int, Never>()
    
    /// when todos is changed, publisher emits cell index. tableview can update specific row.
    var cellChangePublisher: AnyPublisher<Int, Never> {
        publisher.eraseToAnyPublisher()
    }
    
    var numOfItems: Int{
        todos.count
    }

    func cellViewModel(at: Int) -> TodoListCellViewModel{
        let todoItem = todos[at]
        
        return TodoListCellViewModel(parentViewModel: self, model: todoItem)
    }

    func progressViewModel() -> ProgressViewModel {
        
        return ProgressViewModel(from: todos)
    }
    
    init(todos: [TodoItem]) {
        self.todos = todos
    }

    /// change todo completion and send signal to subscribers.
    func toggleComplete(ofId id:String){
        guard let itemIndex = findTodoItem(ofId: id) else { return }
        
        var todoItem = todos[itemIndex]
        todoItem.completed = !todoItem.completed
        
        todos[itemIndex] = todoItem
        
        publisher.send(itemIndex)
    }
    
    private func findTodoItem(ofId id:String) -> Int? {
        return todos.firstIndex { $0.id == id }
    }
}

