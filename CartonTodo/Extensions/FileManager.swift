//
//  FileManager.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 29/7/2022.
//

import Foundation

extension FileManager{
    
    var documentsDirectory: URL {
        let paths = urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
