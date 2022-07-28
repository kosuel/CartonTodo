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
