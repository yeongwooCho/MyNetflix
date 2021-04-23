//
//  HomeViewController.swift
//  MyNetflix
//
//  Created by 조영우 on 2021/04/15.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {

    var awardRecommandListViewController: RecommandListViewController!
    var hotRecommandListViewController: RecommandListViewController!
    var myRecommandListViewController: RecommandListViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "award" {
            let destinationVC = segue.destination as? RecommandListViewController
            awardRecommandListViewController = destinationVC
            awardRecommandListViewController.viewModel.updateType(.award)
            awardRecommandListViewController.viewModel.fetchItems()
        }
        else if segue.identifier == "hot" {
            let destinationVC = segue.destination as? RecommandListViewController
            hotRecommandListViewController = destinationVC
            hotRecommandListViewController.viewModel.updateType(.hot)
            hotRecommandListViewController.viewModel.fetchItems()
        }
        else if segue.identifier == "my" {
            let destinationVC = segue.destination as? RecommandListViewController
            myRecommandListViewController = destinationVC
            myRecommandListViewController.viewModel.updateType(.my)
            myRecommandListViewController.viewModel.fetchItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func playButtonTapped(_ sender: Any) {
        
    }
}
