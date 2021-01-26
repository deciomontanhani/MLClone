//
//  SearchListViewController.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import UIKit

protocol SearchListViewControllerContract: class {
    func showLoading()
    func stopLoading()
    func showError(message: String?)
    func reloadData()
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
        title = "Pesquisando..."
    }

    override func loadView() {
        super.loadView()
        view = customView
    }
}

extension SearchListViewController: SearchListViewControllerContract {
    func showLoading() {
        customView.showLoading()
    }

    func stopLoading() {
        customView.stopLoading()
    }

    func showError(message: String?) {
        customView.showError(message: message)
    }

    func reloadData() {
        customView.reloadData()
    }
}

extension SearchListViewController: SearchListViewDelegate {
    func getProductViewModel(at index: Int) -> ProductCellViewModel? {
        return viewModel.getProductViewModel(at: index)
    }

    func didTapProduct(at index: Int) {
        viewModel.didTapProduct(at: index)
    }

    func getCountList() -> Int {
        viewModel.getCountList()
    }

    func retry() {
        viewModel.retry()
    }
}
