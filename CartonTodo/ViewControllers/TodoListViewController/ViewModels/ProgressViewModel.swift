//
//  ProgressViewModel.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import Foundation

struct ProgressViewModel{
    /// 0...1
    var progressRate: Float {
        Float(completed)/Float(total)
    }
    
    /// (40/100)
    var remainsText: String {
        "(\(completed) / \(total))\n\(remains) left"
    }
    
    private var total: Int
    private var completed: Int
    private var remains: Int{
        total - completed
    }
    
    init(from todos: [TodoItem]) {
        self.completed = todos.filter { $0.completed == true }.count
        self.total = todos.count
    }
}
