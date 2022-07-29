//
//  TodoListCellViewModel.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import Foundation
import UIKit

/// view model for TodoListCell. this view model takes responsibility of toggle event and delegates button event to parent view model
struct TodoListCellViewModel{
    private let model: TodoItem
    private let toggleHandler: (_ todoId: String)->Void
    
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
        toggleHandler(model.id)
    }
    
    init(model:TodoItem, toggleHandler: @escaping (_ todoId: String)->Void){
        self.model = model
        self.toggleHandler = toggleHandler
    }
}
