//
//  SearchViewModelTests.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import MLClone

final class SearchViewModelTests: QuickSpec {

    private var viewModel: SearchViewModel!

    private var mockCoordinator: SearchCoordinatorMock!

    private func setupViewModel() {
        mockCoordinator = SearchCoordinatorMock()
        viewModel = SearchViewModel(coordinator: mockCoordinator)

    }

    override func spec() {
        describe("Given I'm at Search Screen") {
            beforeEach {
                self.setupViewModel()
            }

            context("when user does the search") {
                beforeEach {
                    self.viewModel.didTapSearch(text: "Forno")
                }

                it("should show search results in other screen") {
                    expect(self.mockCoordinator.invokedShowSearchList).to(beTrue())
                    expect(self.mockCoordinator.invokedShowSearchListParameters?.text).to(equal("Forno"))
                }
            }

            context("when user search an empty text") {
                beforeEach {
                    self.viewModel.didTapSearch(text: "")
                }

                it("should not call coordinator") {
                    expect(self.mockCoordinator.invokedShowSearchList).to(beFalse())
                }
            }
        }
    }
}

private final class SearchCoordinatorMock: SearchCoordinatorContract {
    var invokedShowSearchList = false
    var invokedShowSearchListCount = 0
    var invokedShowSearchListParameters: (text: String, Void)?
    var invokedShowSearchListParametersList = [(text: String, Void)]()
    func showSearchList(text: String) {
        invokedShowSearchList = true
        invokedShowSearchListCount += 1
        invokedShowSearchListParameters = (text, ())
        invokedShowSearchListParametersList.append((text, ()))
    }
}
