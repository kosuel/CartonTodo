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
    private var filtedTodos: [TodoItem] = [] /// filtered by title
    
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
        filtedTodos.count
    }

    var numOfCompleted: Int{
        todos.filter { $0.completed == true }.count
    }
    
    func cellViewModel(at: Int) -> TodoListCellViewModel{
        let todoItem = filtedTodos[at]
        
        return TodoListCellViewModel(model: todoItem, toggleHandler: toggleComplete(ofId:))
    }

    func progressViewModel() -> ProgressViewModel {
        
        return ProgressViewModel(from: todos)
    }
    
    init(storageService: StorageService) {
        self.storageService = storageService
        
        storageService.load { [weak self] todos in
            
            self?.todos = todos
            self?.filtedTodos = todos
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
        
        // toggle original todos
        guard let itemIndex = todos.firstIndex(where:{ item in
            item.id == id
        }) else { return }
        
        var todoItem = todos[itemIndex]
        todoItem.completed = !todoItem.completed
        
        todos[itemIndex] = todoItem

        // toggle filted todos
        if let itemIndex = filtedTodos.firstIndex(where:{ item in
            item.id == id
        }) {
            var todoItem = filtedTodos[itemIndex]
            todoItem.completed = !todoItem.completed
            
            filtedTodos[itemIndex] = todoItem
            
            cellPublisher.send(itemIndex)
        }
    }
    
    /// filter todos with title
    func filter(withTitle title:String?){
        if let title = title, title.isEmpty == false {
            filtedTodos = todos.filter { $0.title.localizedCaseInsensitiveContains(title)}
        }
        else{
            filtedTodos = todos
        }
        
        tablePublisher.send()
    }
    
    private func findTodoItem(ofId id:String) -> Int? {
        return todos.firstIndex { $0.id == id }
    }
}

