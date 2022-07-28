//
//  TodoListCell.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import Foundation
import UIKit

class TodoListCell: UITableViewCell{
    static var cellIdentifier = "Cell"

    private var viewModel:TodoListCellViewModel!
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(withViewModel viewModel:TodoListCellViewModel){
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.title
        checkButton.setImage(viewModel.image, for: .normal)
    }
    
    @IBAction func toggleCompleteAction(_ sender: Any) {
        viewModel.toggleComplete()
    }
}
