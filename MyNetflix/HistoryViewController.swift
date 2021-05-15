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
    var searchTerms: [SearchTerm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTerms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else { return UITableViewCell() }
        cell.updateUI(at: searchTerms[indexPath.row].term)
        return cell
    }
}

class HistoryCell: UITableViewCell {
    @IBOutlet weak var searchTerm: UILabel!
    
    func updateUI(at index: String) {
        searchTerm.text = index
    }
}

struct SearchTerm: Codable {
    let term: String
    let timeStamp: TimeInterval
}
