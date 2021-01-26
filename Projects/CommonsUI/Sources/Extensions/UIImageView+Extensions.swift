//
//  UIImageView+Extensions.swift
//  CommonsUI
//
//  Created by Decio Montanhani on 25/01/21.
//

import UIKit

public extension UIImageView {
    static func defaultImageView(image: UIImage? = nil, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = contentMode
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
