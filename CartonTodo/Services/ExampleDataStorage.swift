//
//  ExampleDataStorage.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 29/7/2022.
//

import Foundation

class ExampleStorageService : StorageService{
    
    private var fileURL: URL{
        return FileManager.default.documentsDirectory.appendingPathComponent("todos.json")
    }
    
    func load(completion: @escaping ([TodoItem]) -> Void) {
        
        var todos = [TodoItem(userId: "1", id: "1", title: "buy an apple", completed: false),
                     TodoItem(userId: "1", id: "2", title: "wash my car", completed: true),
                     TodoItem(userId: "1", id: "3", title: "call mom", completed: true),
                     TodoItem(userId: "1", id: "4", title: "study swift", completed: false),
                     TodoItem(userId: "1", id: "5", title: "laundary", completed: false),
                     TodoItem(userId: "1", id: "6", title: "go to coles", completed: false),
                     TodoItem(userId: "1", id: "7", title: "job interview", completed: false),
                     TodoItem(userId: "1", id: "8", title: "check the oil", completed: false)]
        
        /// check if there is saved todos.
        if let data = try? Data(contentsOf: fileURL),
           let savedTodos = try? JSONDecoder().decode([TodoItem].self, from: data) {
            todos = savedTodos
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion( todos )
        }
    }
    
    func save(_ todos:[TodoItem]) {
        
        do{
            let data = try JSONEncoder().encode(todos)
            try data.write(to: fileURL)
        }
        catch{
            print("can't save todos to disk")
        }
    }
}
