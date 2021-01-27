//
//  SearchListViewModelTests.swift
//  MLCloneTests
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofake

@testable import MLClone

final class SearchListViewModelTests: QuickSpec {

    private var viewModel: SearchListViewModel!

    private var mockCoordinator: SearchListCoordinatorMock!

    private var mockRepository: SearchListRepositoryMock!

    private var mockController: SearchListViewControllerMock! {
        didSet {
            viewModel.set(controller: mockController)
        }
    }

    private let searchData: SearchModel = JsonUtil<SearchModel>().decode(from: "SearchList")!

    private func setupViewModel() {
        mockCoordinator = SearchListCoordinatorMock()
        mockRepository = SearchListRepositoryMock()
        viewModel = SearchListViewModel(text: "Forno",
                                        coordinator: mockCoordinator,
                                        repository: mockRepository)
        mockController = SearchListViewControllerMock()
    }

    override func spec() {
        describe("Given I'm at SearchList Screen") {
            beforeEach {
                self.setupViewModel()
            }

            context("when view didLoad successfully") {
                beforeEach {
                    self.mockRepository.stubbedFetchProductsCompletionResult = ((.success(self.searchData)), ())
                    self.viewModel.didLoad()
                }

                it("should set loading in screen to fetch API") {
                    expect(self.mockController.invokedShowLoading).to(beTrue())
                }

                it("should ask to reload data in collection") {
                    expect(self.mockController.invokedReloadData).to(beTrue())
                }
            }

            context("when view didLoad with failure") {
                beforeEach {
                    self.mockRepository.stubbedFetchProductsCompletionResult = ((.failure(.default)), ())
                    self.viewModel.didLoad()
                }

                it("should show error in view") {
                    expect(self.mockController.invokedShowError).to(beTrue())
                    expect(self.mockController.invokedShowErrorParameters?.message)
                        .to(equal("Ops! Estamos com problemas, tente novamente mais tarde."))
                }
            }

            context("when retry searching") {
                beforeEach {
                    self.mockRepository.stubbedFetchProductsCompletionResult = ((.success(self.searchData)), ())
                    self.viewModel.retry()
                }

                it("should invoke repository") {
                    expect(self.mockRepository.invokedFetchProducts).to(beTrue())
                }
            }

            context("when view asks for number of results") {
                beforeEach {
                    self.mockRepository.stubbedFetchProductsCompletionResult = ((.success(self.searchData)), ())
                    self.viewModel.didLoad()
                }

                it("should return four") {
                    expect(self.viewModel.getCountList()).to(equal(4))
                }
            }

            context("when view need cell viewModel in a inexistent position") {
                beforeEach {
                    self.mockRepository.stubbedFetchProductsCompletionResult = ((.success(self.searchData)), ())
                    self.viewModel.didLoad()
                }

                it("should return nil") {
                    let cellModel = self.viewModel.getProductViewModel(at: 30)
                    expect(cellModel).to(beNil())
                }
            }

            context("when view needs cell viewModel") {
                beforeEach {
                    self.mockRepository.stubbedFetchProductsCompletionResult = ((.success(self.searchData)), ())
                    self.viewModel.didLoad()
                }

                it("should return viewModel correctly") {
                    let cellModel = self.viewModel.getProductViewModel(at: 0)
                    expect(cellModel?.price).to(equal("R$ 9.899,00"))
                    expect(cellModel?.freeShipping).to(equal(true))
                    expect(cellModel?.productName).to(equal("iPhone 11 Pro Max 256 Gb Cinza-espacial"))
                }
            }

            context("when user tapped in cell") {
                beforeEach {
                    self.mockRepository.stubbedFetchProductsCompletionResult = ((.success(self.searchData)), ())
                    self.viewModel.didLoad()
                    self.viewModel.didTapProduct(at: 0)
                }

                it("should call product detail screen") {
                    expect(self.mockCoordinator.invokedShowProductDetail).to(beTrue())
                    expect(self.mockCoordinator.invokedShowProductDetailParameters?.productId).to(equal("MLB1742066740"))
                }
            }

            context("when user tapped in indexPath that doesn't exists") {
                beforeEach {
                    self.viewModel.didTapProduct(at: 0)
                }

                it("should not invoke coordinator") {
                    expect(self.mockCoordinator.invokedShowProductDetail).to(beFalse())
                }
            }
        }
    }
}

private final class SearchListViewControllerMock: SearchListViewControllerContract {
    var invokedShowLoading = false
    var invokedShowLoadingCount = 0
    func showLoading() {
        invokedShowLoading = true
        invokedShowLoadingCount += 1
    }
    var invokedStopLoading = false
    var invokedStopLoadingCount = 0
    func stopLoading() {
        invokedStopLoading = true
        invokedStopLoadingCount += 1
    }
    var invokedShowError = false
    var invokedShowErrorCount = 0
    var invokedShowErrorParameters: (message: String?, Void)?
    var invokedShowErrorParametersList = [(message: String?, Void)]()
    func showError(message: String?) {
        invokedShowError = true
        invokedShowErrorCount += 1
        invokedShowErrorParameters = (message, ())
        invokedShowErrorParametersList.append((message, ()))
    }
    var invokedReloadData = false
    var invokedReloadDataCount = 0
    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }
}

private final class SearchListRepositoryMock: SearchListRepositoryContract {
    var invokedFetchProducts = false
    var invokedFetchProductsCount = 0
    var invokedFetchProductsParameters: (text: String, Void)?
    var invokedFetchProductsParametersList = [(text: String, Void)]()
    var stubbedFetchProductsCompletionResult: (Result<SearchModel, NetworkError>, Void)?
    func fetchProducts(text: String, completion: @escaping (Result<SearchModel, NetworkError>) -> Void) {
        invokedFetchProducts = true
        invokedFetchProductsCount += 1
        invokedFetchProductsParameters = (text, ())
        invokedFetchProductsParametersList.append((text, ()))
        if let result = stubbedFetchProductsCompletionResult {
            completion(result.0)
        }
    }
}

private final class SearchListCoordinatorMock: SearchListCoordinatorContract {
    var invokedShowProductDetail = false
    var invokedShowProductDetailCount = 0
    var invokedShowProductDetailParameters: (productId: String, Void)?
    var invokedShowProductDetailParametersList = [(productId: String, Void)]()
    func showProductDetail(with productId: String) {
        invokedShowProductDetail = true
        invokedShowProductDetailCount += 1
        invokedShowProductDetailParameters = (productId, ())
        invokedShowProductDetailParametersList.append((productId, ()))
    }
}
