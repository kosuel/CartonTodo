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
    
    /// servcie for loading and saving todos
    private var storageService: StorageService
    
    @Published var isLoading = true
    
    private var todos: [TodoItem] = []
    
    private var cellPublisher = PassthroughSubject<Int, Never>()
    private var tablePublisher = PassthroughSubject<Void, Never>()
    
    /// when todos is changed, publisher emits cell index. tableview can update specific row.
    var cellChangePublisher: AnyPublisher<Int, Never> {
        cellPublisher.eraseToAnyPublisher()
    }
    
    /// reload whole tableview
    var tableChangePublisher: AnyPublisher<Void, Never> {
        tablePublisher.eraseToAnyPublisher()
    }
    
    var numOfItems: Int{
        todos.count
    }

    var numOfCompleted: Int{
        todos.filter { $0.completed == true }.count
    }
    
    func cellViewModel(at: Int) -> TodoListCellViewModel{
        let todoItem = todos[at]
        
        return TodoListCellViewModel(model: todoItem, toggleHandler: toggleComplete(ofId:))
    }

    func progressViewModel() -> ProgressViewModel {
        
        return ProgressViewModel(from: todos)
    }
    
    init(storageService: StorageService) {
        self.storageService = storageService
        
        storageService.load { [weak self] todos in
            
            self?.todos = todos
            self?.tablePublisher.send()
            self?.isLoading = false
        }
    }
    
    /// save changes
    deinit {
        if todos.isEmpty == false {
            storageService.save( todos )
        }
    }

    /// change todo completion and send signal to subscribers.
    func toggleComplete(ofId id:String){
        guard let itemIndex = findTodoItem(ofId: id) else { return }
        
        var todoItem = todos[itemIndex]
        todoItem.completed = !todoItem.completed
        
        todos[itemIndex] = todoItem

        cellPublisher.send(itemIndex)
    }
    
    private func findTodoItem(ofId id:String) -> Int? {
        return todos.firstIndex { $0.id == id }
    }
}

