//
//  ToDoListViewModel.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import Foundation
import UIKit
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

/// view model for TodoListCell. this view model takes responsibility of toggle event and delegates button event to parent view model
struct TodoListCellViewModel{
    private let parentViewModel: TodoListViewModel
    private let model: TodoItem

    var title: String {
        model.title
    }
    
    var isCompleted: Bool {
        model.completed
    }
    
    var image: UIImage{
        UIImage(systemName: isCompleted ? "checkmark.circle" : "circle")!
    }

    func toggleComplete(){
        parentViewModel.toggleComplete(ofId: model.id)
    }
    
    init(parentViewModel:TodoListViewModel, model:TodoItem){
        self.parentViewModel = parentViewModel
        self.model = model
    }
}
