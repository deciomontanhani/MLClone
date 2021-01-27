//
//  ProductDetailViewModelTests.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofake

@testable import MLClone

final class ProductDetailViewModelTests: QuickSpec {

    private var viewModel: ProductDetailViewModel!

    private var mockCoordinator: ProductDetailCoordinatorMock!

    private var mockRepository: ProductDetailRepositoryMock!

    private var mockController: ProductDetailViewControllerMock! {
        didSet {
            viewModel.set(controller: mockController)
        }
    }

    private let searchData: [ProductDetailModel] = JsonUtil<[ProductDetailModel]>().decode(from: "ProductDetail")!

    private func setupViewModel() {
        mockCoordinator = ProductDetailCoordinatorMock()
        mockRepository = ProductDetailRepositoryMock()
        viewModel = ProductDetailViewModel(productId: "MBL94351231",
                                           coordinator: mockCoordinator,
                                           repository: mockRepository)
        mockController = ProductDetailViewControllerMock()
    }

    override func spec() {
        describe("Given I'm at ProductDetail Screen") {
            beforeEach {
                self.setupViewModel()
            }

            context("when view didLoad successfully") {
                beforeEach {
                    self.mockRepository.stubbedFetchDetailCompletionResult = ((.success(self.searchData)), ())
                    self.viewModel.didLoad()
                }

                it("should show loading in view") {
                    expect(self.mockController.invokedShowLoading).to(beTrue())
                }

                it("should setup view with viewModel") {
                    expect(self.mockController.invokedSetup).to(beTrue())
                    let model = self.mockController.invokedSetupParameters?.model

                    expect(model?.price).to(equal("R$ 9.899,00"))
                    expect(model?.productTitle).to(equal("iPhone 11 Pro Max 256 Gb Cinza-espacial"))
                    expect(model?.soldQuantity).to(equal("2 vendidos"))
                }
            }

            context("when view didLoad with failure") {
                beforeEach {
                    self.mockRepository.stubbedFetchDetailCompletionResult = ((.failure(.default)), ())
                    self.viewModel.didLoad()
                }

                it("should show error message in view") {
                    expect(self.mockController.invokedShowError).to(beTrue())
                    expect(self.mockController.invokedShowErrorParameters?.message)
                        .to(equal("Ops! Estamos com problemas, tente novamente mais tarde."))
                }
            }
        }
    }
}

private final class ProductDetailViewControllerMock: ProductDetailViewControllerContract {
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
    var invokedSetup = false
    var invokedSetupCount = 0
    var invokedSetupParameters: (model: ProductPresentationModel, Void)?
    var invokedSetupParametersList = [(model: ProductPresentationModel, Void)]()
    func setup(with model: ProductPresentationModel) {
        invokedSetup = true
        invokedSetupCount += 1
        invokedSetupParameters = (model, ())
        invokedSetupParametersList.append((model, ()))
    }
}

private final class ProductDetailCoordinatorMock: ProductDetailCoordinatorContract {}

private final class ProductDetailRepositoryMock: ProductDetailRepositoryContract {
    var invokedFetchDetail = false
    var invokedFetchDetailCount = 0
    var invokedFetchDetailParameters: (productId: String, Void)?
    var invokedFetchDetailParametersList = [(productId: String, Void)]()
    var stubbedFetchDetailCompletionResult: (Result<[ProductDetailModel], NetworkError>, Void)?
    func fetchDetail(productId: String, completion: @escaping (Result<[ProductDetailModel], NetworkError>) -> Void) {
        invokedFetchDetail = true
        invokedFetchDetailCount += 1
        invokedFetchDetailParameters = (productId, ())
        invokedFetchDetailParametersList.append((productId, ()))
        if let result = stubbedFetchDetailCompletionResult {
            completion(result.0)
        }
    }
}
