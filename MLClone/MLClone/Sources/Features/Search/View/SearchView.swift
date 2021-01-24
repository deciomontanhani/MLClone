//
//  SearchView.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import UIKit

protocol SearchViewDelegate: class {
    func didTapSearch(text: String)
}

final class SearchView: UIView {

    weak var delegate: SearchViewDelegate?

    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.delegate = self
        view.autocapitalizationType = .none
        view.placeholder = "Digite um produto"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        addSubview(searchBar)
        addSubview(welcomeTitle)
    }

    func buildConstraints() {
        searchBar.safeAreaTop(to: self)
        searchBar.horizontal(of: self)

        welcomeTitle.center(in: self)
    }
}

extension SearchView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didTapSearch(text: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}
