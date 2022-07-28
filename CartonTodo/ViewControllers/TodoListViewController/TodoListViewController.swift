//
//  TodoListViewController.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import Foundation
import UIKit
import Combine

class TodoListViewController: UIViewController{
    
    private var viewModel = TodoListViewModel.dummyViewModel
    
    @IBOutlet weak var tableView: UITableView!
    
    private var cancels = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Todos", comment: "")
        
        viewModel.cellChangePublisher
            .sink { [weak self] cellIndex in
                self?.tableView.reloadRows(at: [IndexPath(row: cellIndex, section: 0)], with: .automatic)
            }
            .store(in: &cancels)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Log out", comment: ""), style: .plain, target: self, action: #selector(logOutAction(_:)))
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        LoginManager.shared.isLogin = false
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
