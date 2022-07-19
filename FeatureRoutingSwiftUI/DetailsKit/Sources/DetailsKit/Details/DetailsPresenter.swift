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
    private let router = DetailsRouter()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }

    func makeExtraDetailsView<Label: View>(viewModel: DetailsViewModel, @ViewBuilder label: () -> Label) -> AnyView {
        //router.makeModalExtraDetailsView(viewModel: viewModel, label: label)
        fatalError()
    }
}
