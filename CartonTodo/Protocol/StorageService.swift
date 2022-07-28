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
}
