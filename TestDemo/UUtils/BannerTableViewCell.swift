//
//  BannerTableViewCell.swift
//  TestDemo
//
//  Created by Sparkout on 06/06/23.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    var viewModel: [Restaurant] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.registerNib(BannerCollectionViewCell.self)
        bannerView.layer.borderWidth = 0.2
        bannerView.layer.borderColor = UIColor.gray.cgColor
    }
}

extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BannerCollectionViewCell = collectionView.dequeueReusableCell(BannerCollectionViewCell.self, indexPath: indexPath)
        cell.bannerLabel.text = viewModel[indexPath.item].restaurantName
        guard let url = URL(string: self.viewModel[indexPath.item].image!) else {
            return UICollectionViewCell()
        }
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.bannerImageView.image = image
                    }
                }
            }
        }
        return cell
    }
}
