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
    
    private var viewModel = TodoListViewModel(storageService: NetworkDataStorage())
    
    @IBOutlet weak var tableView: UITableView!    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var cancels = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Todos", comment: "")

        setupBind()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Log out", comment: ""), style: .plain, target: self, action: #selector(logOutAction(_:)))
    }
    
    private func setupBind(){
        /// subscribe whole data changing
        viewModel.tableChangePublisher
            .sink { [weak self] in
                self?.tableView.reloadData()
            }
            .store(in: &cancels)
        
        /// specific row change observing
        viewModel.cellChangePublisher
            .sink { [weak self] cellIndex in
                guard let self = self else { return }
                
                // update cell
                self.tableView.reloadRows(at: [IndexPath(row: cellIndex, section: 0)], with: .automatic)
                
                // update remains view
                guard let headerView = self.tableView.headerView(forSection: 0) as? TodoProgressView else { return }
                
                headerView.configure(withViewModel: self.viewModel.progressViewModel())
            }
            .store(in: &cancels)
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        LogInManager.shared.isLogin = false
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let todoProgressView = TodoProgressView.instantiateFromNib()
        
        todoProgressView.configure(withViewModel: viewModel.progressViewModel())
        
        return todoProgressView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
}

extension TodoListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(withTitle: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filter(withTitle: nil)
        
        searchBar.resignFirstResponder()
    }
}


extension TodoListViewController{
    
    static func instantiateInitialViewController() -> UIViewController{
        return UIStoryboard(name: "TodoListViewController", bundle: nil).instantiateInitialViewController()!
    }
}
