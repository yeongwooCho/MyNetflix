//
//  RecommandListViewController.swift
//  MyNetflix
//
//  Created by 조영우 on 2021/04/16.
//

import UIKit

class RecommandListViewController: UIViewController {

    @IBOutlet weak var sectionLabel: UILabel!
    let viewModel = RecommandViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        sectionLabel.text = viewModel.type.title
    }
}

extension RecommandListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandCell", for: indexPath) as? RecommandCell else {
            return UICollectionViewCell()
        }
        
        let movie = viewModel.items(at: indexPath.item)
        cell.updateUI(movie: movie)
        return cell
    }
}

extension RecommandListViewController: UICollectionViewDelegate {
    
}

extension RecommandListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
}

class RecommandViewModel {
    enum RecommandingType {
        case award
        case hot
        case my
        
        var title: String {
            switch self {
            case .award: return "아카데미 호황 영화"
            case .hot: return "취향저격 Hot 컨텐츠"
            case .my: return "내가 찜한 컨텐츠"
            }
        }
    }
    
    private (set) var type: RecommandingType = .my
    private var items: [DummyItem] = []
    
    var numOfItems: Int {
        return items.count
    }
    
    func items(at index: Int) -> DummyItem {
        return items[index]
    }
    
    func updateType(_ type: RecommandingType) {
        self.type = type
    }
    
    func fetchItems() {
        
    }
}

class RecommandCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    func updateUI(movie: DummyItem) {
        thumbnailImage.image = movie.thumbnail
    }
}


struct DummyItem {
    let thumbnail: UIImage
}
