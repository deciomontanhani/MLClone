//
//  UICollectionView+Extensions.swift
//  MLClone
//
//  Created by Decio Montanhani on 25/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import UIKit

public extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        register(cellType, forCellWithReuseIdentifier: cellType.className)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                             for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T
    }

    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                                 for indexPath: IndexPath,
                                                                 ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T? {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as? T
    }
}
