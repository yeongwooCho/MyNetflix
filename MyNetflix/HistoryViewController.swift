//
//  HistoryViewController.swift
//  MyNetflix
//
//  Created by 조영우 on 2021/05/13.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let db = Database.database(url: "https://mynetflix-6ae7e-default-rtdb.firebaseio.com/").reference().child("searchHistory")
//    var searchTerms: [SearchTerm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
