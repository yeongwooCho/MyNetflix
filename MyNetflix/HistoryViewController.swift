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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        db.observeSingleEvent(of: .value) { snapshot in
            guard let searchHistory = snapshot.value as? [String: Any] else { return }
            
//            let data = try! JSONSerialization.data(withJSONObject: Array(searchHistory.values), options: [])
//            let decoder = JSONDecoder()
//            let searchTerms = try! decoder.decode([SearchTerm].self, from: data)
//            print("data: \(data)")
//            print("searchTerm: \(searchTerms)")
            
            do {
                let data = try JSONSerialization.data(withJSONObject: Array(searchHistory.values), options: [])
                let decoder = JSONDecoder()
                let searchTerms = try decoder.decode([SearchTerm].self, from: data)
                self.searchTerms = searchTerms.sorted(by: { term1, term2 in
                    return term1.timeStamp > term2.timeStamp
                })
                self.tableView.reloadData()
            } catch let error {
                print("error: \(error.localizedDescription)")
            }
        }
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
