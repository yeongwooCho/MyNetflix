//
//  SearchViewController.swift
//  MyNetflix
//
//  Created by 조영우 on 2021/04/15.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // TODO
        // 키보드가 올라와 있을때 내려가도록 처리
        dismissKeyboard()
        
        // 검색어가 있는지 확인
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
        
        // 네트워킹을 통한 검색
        // - 목표: searchTerm을 갖고 네트워킹을 통해서 영화 검색
        // - 검색 API 필요
        // - 결과를 받아올 모델 Movie, Response
        // - 결과를 받아와서 CollectionView로 표현해주자
        
        print("---> 검색결과: \(searchTerm)")
    }
}
