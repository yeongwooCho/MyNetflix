//
//  RecommandListViewController.swift
//  MyNetflix
//
//  Created by 조영우 on 2021/04/16.
//

import UIKit

class RecommandListViewController: UIViewController {

    @IBOutlet weak var sectionLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        
    }
}

extension RecommandListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.numOfItems
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandCell", for: indexPath) as? RecommandCell else {
            return UICollectionViewCell()
        }
        
//        let movie = viewModel.items(at: indexPath.item)
//        cell.updateUI(movie: movie)
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

class RecommandCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    func updateUI(movie: DummyItem) {
        thumbnailImage.image = movie.thumbnail
    }
}

struct DummyItem {
    let thumbnail: UIImage
}
