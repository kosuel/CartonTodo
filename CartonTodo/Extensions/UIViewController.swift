//
//  UIViewController.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import UIKit

extension UIViewController {
    func showAlert(title:String?, message:String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default))
        
        present(alert, animated: true)
    }
}
