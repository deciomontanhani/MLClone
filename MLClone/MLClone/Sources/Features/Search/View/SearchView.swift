//
//  SearchView.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import UIKit

final class SearchView: UIView {

    private let welcomeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Seja bem vindo! Faça uma busca abaixo"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildViewCode()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

extension SearchView: ViewCode {
    func buildHierarchy() {
        addSubview(welcomeTitle)
    }

    func buildConstraints() {
        welcomeTitle.center(in: self)
    }
}
