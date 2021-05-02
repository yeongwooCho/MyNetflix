//
//  SearchViewController.swift
//  MyNetflix
//
//  Created by 조영우 on 2021/04/15.
//

import UIKit
import Kingfisher
import AVFoundation

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else {
            return UICollectionViewCell()
        }
        cell.updateUI(at: movies[indexPath.item])
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // movie를 playerViewController로 전달
        // player VC + movie 로 PlayerView를 띄운다.
        let movie = movies[indexPath.item]
        let url = URL(string: movie.previewURL)!
        let item = AVPlayerItem(url: url)
        
        let sb = UIStoryboard(name: "Player", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
        vc.player.replaceCurrentItem(with: item)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let margin: CGFloat = 8
        let width: CGFloat = (view.bounds.width - itemSpacing*2 - margin*2) / 3
        let height: CGFloat = width * 10 / 7
        return CGSize(width: width, height: height)
    }
}

class ResultCell: UICollectionViewCell {
    @IBOutlet weak var movieThumbnail: UIImageView!
    
    func updateUI(at indexMovie: Movie) {
        let url = URL(string: indexMovie.thumbnailPath)!
        self.movieThumbnail.kf.setImage(with: url)
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
        // - [x] 검색 API 필요
        // - [x] 결과를 받아올 모델 Movie, Response
        // - 결과를 받아와서 CollectionView로 표현해주자
        SearchAPI.search(searchTerm) { (movies) in
            // collectionView 로 표현하기
            DispatchQueue.main.async {
                self.movies = movies
                self.resultCollectionView.reloadData()
            }
        }
//        print("---> 검색결과: \(searchTerm)")
    }
}

class SearchAPI {
    static func search(_ term: String, completion: @escaping ([Movie]) -> Void) {
        let session = URLSession(configuration: .default)
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
        let mediaQueryItem = URLQueryItem(name: "media", value: "movie")
        let entityQueryItem = URLQueryItem(name: "entity", value: "movie")
        let termQueryItem = URLQueryItem(name: "term", value: term)
        urlComponents.queryItems?.append(mediaQueryItem)
        urlComponents.queryItems?.append(entityQueryItem)
        urlComponents.queryItems?.append(termQueryItem)
        let requestURL = urlComponents.url! // optional을 열어서 변수에 넣는다.
        
        let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
            let successRange = 200..<300
            // error가 없다. response의 상태코드가 존재한다. 상태코드는 200대 이다. 다음 조건이 만족해야한다.
            guard error == nil,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successRange.contains(statusCode) else {
                completion([])
                return
            }
            guard let resultData = data else {
                completion([])
                return
            }
            
            // data -> [Movie] 이를 위해서는 data의 parsing이 필요하고 어랴애 존재하는 Response와 Movie가 protocol
            let movies = SearchAPI.parseMovies(resultData)
            completion(movies)
        }
        dataTask.resume()
    }
    
    static func parseMovies(_ data: Data) -> [Movie] {
        let decoder = JSONDecoder()
        
        do {
            let response = try decoder.decode(Response.self, from: data) // parsing이 안될 수 있다.
            return response.movies
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
}

struct Response: Codable {
    let resultCount: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case resultCount
        case movies = "results"
    }
}

struct Movie: Codable {
    let title: String
    let director: String
    let thumbnailPath: String
    let previewURL: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case director = "artistName"
        case thumbnailPath = "artworkUrl100"
        case previewURL = "previewUrl"
    }
}
