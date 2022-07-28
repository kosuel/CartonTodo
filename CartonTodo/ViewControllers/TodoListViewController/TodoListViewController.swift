//
//  TodoListViewController.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import Foundation
import UIKit

class TodoListViewController: UIViewController{
    
    private var viewModel = TodoListViewModel.dummyViewModel
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListCell.cellIdentifier, for: indexPath) as? TodoListCell else {
            return UITableViewCell()
        }

        cell.configure(withViewModel: viewModel.cellViewModel(at: indexPath.row))
        
        return cell
    }
}

extension TodoListViewController{
    
    static func instantiateInitialViewController() -> UIViewController{
        return UIStoryboard(name: "TodoListViewController", bundle: nil).instantiateInitialViewController()!
    }
}
