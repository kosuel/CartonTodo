//
//  ChangeStorage.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 29/7/2022.
//

import Foundation

protocol StorageService{
    
    /// load saved todo
    func load(completion: @escaping ([TodoItem])->Void )
    
    func save(_ todos:[TodoItem])
    
    ///  remove local save or memory cache
    func resetCache()
}

/// file I/O helper
extension StorageService{
    
    private var fileURL: URL{
        return FileManager.default.documentsDirectory.appendingPathComponent("todos.json")
    }
    
    func loadFromFile() -> [TodoItem]?{

        guard let data = try? Data(contentsOf: fileURL),
              let savedTodos = try? JSONDecoder().decode([TodoItem].self, from: data) else { return nil }

        return savedTodos
    }
    
    func saveToFile(_ todos:[TodoItem]) {
        
        do{
            let data = try JSONEncoder().encode(todos)
            try data.write(to: fileURL)
        }
        catch{
            print("can't save todos to disk")
        }
    }
    
    func removeLocalFile() {
        do{
            try FileManager.default.removeItem(at: fileURL)
        }
        catch{
            print(error)
        }
    }
}
