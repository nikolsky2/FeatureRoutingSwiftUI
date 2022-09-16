//
//  DetailsPresenter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI

@MainActor
class DetailsPresenter: ObservableObject {
    @Published var viewModel: DetailsViewModel
    private let router: DetailsRouting
    
    init(viewModel: DetailsViewModel, router: DetailsRouting) {
        self.viewModel = viewModel
        self.router = router
    }

    func didTouchDismiss() {
        router.dismissDetails()
    }

    func didTouchExtra() {
        router.presentExtraDetails(viewModel.id)
    }
}
