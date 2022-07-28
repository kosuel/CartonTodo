//
//  SectionHeadView.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import Foundation
import UIKit

class TodoProgressView: UITableViewHeaderFooterView{
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    func configure(withViewModel viewModel:ProgressViewModel){
        remainingLabel.text = viewModel.remainsText
        progressBar.setProgress(viewModel.progressRate, animated: true)
    }
}


extension TodoProgressView {
    
    static func instantiateFromNib() -> TodoProgressView{
        let nib = UINib(nibName: "TodoProgressView", bundle: nil)
        let view = nib.instantiate (withOwner: nil, options: nil).first as! TodoProgressView
        return view
    }
}
