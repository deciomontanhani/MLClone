//
//  SearchViewController.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import UIKit

class SearchViewController: UIViewController {

    private lazy var customView: UIView = {
        let view = SearchView()
        view.delegate = self
        return view
    }()

    private let viewModel: SearchViewModelContract

    init(viewModel: SearchViewModelContract) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mercado Livre"
    }

    override func loadView() {
        super.loadView()
        view = customView
    }
}

extension SearchViewController: SearchViewDelegate {
    func didTapSearch(text: String) {
        viewModel.didTapSearch(text: text)
    }
}
