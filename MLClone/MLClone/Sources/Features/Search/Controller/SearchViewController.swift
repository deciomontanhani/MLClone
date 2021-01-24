//
//  SearchViewController.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import UIKit

class SearchViewController: UIViewController {

    private let customView: UIView = SearchView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        super.loadView()
        view = customView
    }
}
