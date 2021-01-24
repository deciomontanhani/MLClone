//
//  SearchListView.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import UIKit

protocol SearchListViewContract: UIView {

}

protocol SearchListViewDelegate: class {

}

final class SearchListView: UIView {
    weak var delegate: SearchListViewDelegate?

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

    }

    func buildConstraints() {

    }

    func additionalSetup() {
        backgroundColor = .yellow
    }
}

extension SearchListView: SearchListViewContract {

}
