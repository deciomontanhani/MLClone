//
//  LoadingErrorView.swift
//  MLClone
//
//  Created by Decio Montanhani on 25/01/21.
//  Copyright © 2021 Decio Montanhani. All rights reserved.
//

import UIKit

public protocol LoadingErrorViewProtocol: AnyObject {
    func retry()
}

public enum LoadingErrorViewState {
    case loading
    case error
    case hidden
    case none(message: String)
}

public final class LoadingErrorView: UIView {

    weak var delegate: LoadingErrorViewProtocol?

    private var text: String? {
        didSet {
            title.text = text
        }
    }

    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.text = "Não foi possível realizar a busca"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tryButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Tentar novamente", for: .normal)
        button.addTarget(self, action: #selector(didTapRetry), for: .touchUpInside)
        return button
    }()

    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [title, tryButton, spinner])
        stack.alignment = .center
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    public init() {
        super.init(frame: .zero)
        buildViewCode()
        loading()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    public func set(state: LoadingErrorViewState) {
        DispatchQueue.main.async {
            switch state {
            case .loading:
                self.loading()
            case .error:
                self.error()
            case .hidden:
                self.hidden()
            case .none(let message):
                self.none(message: message)
            }
        }
    }

    public func set(text: String? = "Não foi possível realizar a busca") {
        self.text = text
    }
}

private extension LoadingErrorView {
    @objc
    func didTapRetry() {
        delegate?.retry()
    }

    func loading() {
        title.isHidden = true
        tryButton.isHidden = true
        spinner.isHidden = false
        isHidden = false
    }
    func error() {
        title.isHidden = false
        tryButton.isHidden = false
        spinner.isHidden = true
        isHidden = false
    }
    func hidden() {
        isHidden = true
    }

    func none(message: String) {
        set(text: message)
        title.isHidden = false
        tryButton.isHidden = true
        spinner.isHidden = true
        isHidden = false
    }
}

extension LoadingErrorView: ViewCode {
    public func buildHierarchy() {
        addSubview(contentStack)
    }

    public func buildConstraints() {
        contentStack.center(in: self)
        contentStack.left(to: self, offset: 24)
        contentStack.right(to: self, offset: 24)
    }

    public func additionalSetup() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
}
