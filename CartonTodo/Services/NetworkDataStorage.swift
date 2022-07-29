//
//  NetworkDataStorage.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 29/7/2022.
//

import Foundation
import GenericJSON

class NetworkDataStorage : StorageService{

    func load(completion: @escaping ([TodoItem]) -> Void) {
        
        /// check if there is saved todos.
        if let todos = loadFromFile() {
            completion( todos )
        }
        /// download from website
        else{
            URLSession.shared.startDataTask(with: URL(string: "https://jsonplaceholder.typicode.com/todos")!) { result in
                
                guard case let .success(data) = result,
                let json = try? JSONDecoder().decode(JSON.self, from: data),
                let jsonArray = json.arrayValue else {
                    
                    DispatchQueue.main.async {
                        completion( [] )
                    }
                    return
                }

                var todos = [TodoItem]()
                for obj in jsonArray{
                    
                    guard let userId = obj["userId"]?.doubleValue,
                          let id = obj["id"]?.doubleValue,
                          let title = obj["title"]?.stringValue,
                          let completed = obj["completed"]?.boolValue else { continue }
                    
                    todos.append( TodoItem(userId: String(userId), id: String(id), title: title, completed: completed) )
                }
                
                DispatchQueue.main.async {
                    completion(todos)
                }
            }
        }
        
    }
    
    func save(_ todos:[TodoItem]) {
        saveToFile(todos)
    }

    func resetCache(){
        removeLocalFile()
    }

}
