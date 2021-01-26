//
//  SearchListView.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import UIKit
import CommonsUI

protocol SearchListViewContract: UIView {
    func showLoading()
    func stopLoading()
    func showError(message: String?)
    func reloadData()
}

protocol SearchListViewDelegate: class {
    func retry()
    func getCountList() -> Int
    func getProductViewModel(at index: Int) -> ProductCellViewModel?
    func didTapProduct(at index: Int)
}

final class SearchListView: UIView {
    weak var delegate: SearchListViewDelegate?

    private lazy var loadingErrorView: LoadingErrorView = {
        let view = LoadingErrorView()
        view.set(state: .loading)
        view.delegate = self
        return view
    }()

    private lazy var productsList: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = MLColor.Background.lightGray
        view.delegate = self
        view.dataSource = self
        view.registerCell(cellType: ProductCollectionViewCell.self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildViewCode()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

extension SearchListView: ViewCode {
    func buildHierarchy() {
        addSubview(productsList)
        addSubview(loadingErrorView)
    }

    func buildConstraints() {
        loadingErrorView.edges(to: self)

        productsList.edges(to: self, excluding: .top)
        productsList.safeAreaTop(to: self)
    }

    func additionalSetup() {
        backgroundColor = .white
    }
}

extension SearchListView: SearchListViewContract {
    func reloadData() {
        stopLoading()
        productsList.reloadData()
    }

    func showLoading() {
        loadingErrorView.set(state: .loading)
    }

    func stopLoading() {
        loadingErrorView.set(state: .hidden)
    }

    func showError(message: String?) {
        loadingErrorView.set(text: message)
        loadingErrorView.set(state: .error)
    }
}

extension SearchListView: LoadingErrorViewProtocol {
    func retry() {
        delegate?.retry()
    }
}

extension SearchListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension SearchListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}

extension SearchListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.getCountList() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cellViewModel = delegate?.getProductViewModel(at: indexPath.row),
            let cell = productsList.dequeueReusableCell(with: ProductCollectionViewCell.self, for: indexPath)
        else {
            return UICollectionViewCell()
        }

        cell.set(viewModel: cellViewModel)

        return cell
    }
}
