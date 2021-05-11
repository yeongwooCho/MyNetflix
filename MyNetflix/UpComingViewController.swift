//
//  UpComingViewController.swift
//  MyNetflix
//
//  Created by 조영우 on 2021/05/11.
//

import UIKit

class UpComingViewController: UIViewController {

    var firstRecommandListViewController: RecommandListViewController!
    var secondRecommandListViewController: RecommandListViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "first" {
            let destinationVC = segue.destination as? RecommandListViewController
            firstRecommandListViewController = destinationVC
            firstRecommandListViewController.viewModel.updateType(.hot)
            firstRecommandListViewController.viewModel.fetchItems()
        } else if segue.identifier == "second" {
            let destinationVC = segue.destination as? RecommandListViewController
            secondRecommandListViewController = destinationVC
            secondRecommandListViewController.viewModel.updateType(.my)
            secondRecommandListViewController.viewModel.fetchItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
