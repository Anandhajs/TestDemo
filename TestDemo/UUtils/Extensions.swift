//
//  Extensions.swift
//  TestDemo
//
//  Created by Sparkout on 05/06/23.
//

import Foundation
import UIKit

protocol NibLoadableView: AnyObject { }

extension NibLoadableView where Self: UIView {
    static var nib: UINib { return UINib(nibName: String(describing: self), bundle: .main) }
}

protocol TableReusableView: AnyObject { }

extension TableReusableView where Self: UIView {
    static var identifier: String { return String(describing: self) }
}

extension UICollectionViewCell: NibLoadableView, TableReusableView { }

extension UICollectionView {

    func registerNib<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else { return T() }
        return cell
    }
}


extension UITableViewCell: NibLoadableView, TableReusableView { }

extension UITableView {

    func registerNib<T: UITableViewCell>(_ type: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else { return T() }
        return cell
    }
}
