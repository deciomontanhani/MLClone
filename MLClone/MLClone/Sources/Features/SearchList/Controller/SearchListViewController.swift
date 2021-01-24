//
//  SearchListViewController.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import UIKit

protocol SearchListViewControllerContract {
    
}

final class SearchListViewController: UIViewController {

    private lazy var customView: SearchListViewContract = {
        let view = SearchListView()
        view.delegate = self
        return view
    }()

    private let viewModel: SearchListViewModelContract

    init(viewModel: SearchListViewModelContract) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didLoad()
    }

    override func loadView() {
        super.loadView()
        view = customView
    }
}

extension SearchListViewController: SearchListViewControllerContract {

}

extension SearchListViewController: SearchListViewDelegate {

}
