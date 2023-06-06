//
//  NearTableViewCell.swift
//  TestDemo
//
//  Created by Sparkout on 05/06/23.
//

import UIKit

class NearTableViewCell: UITableViewCell {

    @IBOutlet weak var nearView: UIView!
    @IBOutlet weak var nearCollectionView: UICollectionView!
    
    var viewModel: [Restaurant] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        nearCollectionView.delegate = self
        nearCollectionView.dataSource = self
        nearCollectionView.registerNib(NearCollectionViewCell.self)
        nearView.layer.borderWidth = 0.2
        nearView.layer.borderColor = UIColor.gray.cgColor
    }
}

extension NearTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NearCollectionViewCell = collectionView.dequeueReusableCell(NearCollectionViewCell.self, indexPath: indexPath)
        cell.nearLabel.text = viewModel[indexPath.item].restaurantName
        guard let url = URL(string: self.viewModel[indexPath.item].image!) else {
            return UICollectionViewCell()
        }
        DispatchQueue.main.async {
                   if let data = try? Data(contentsOf: url) {
                       if let image = UIImage(data: data) {
                           DispatchQueue.main.async {
                               cell.nearImageView.image = image
                           }
                       }
                   }
               }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 140)
    }
}
