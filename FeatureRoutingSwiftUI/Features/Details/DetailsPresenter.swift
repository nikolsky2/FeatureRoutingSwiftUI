//
//  DetailsPresenter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI

class DetailsPresenter: ObservableObject {
    let viewModel: GrapeViewModel
    private let router = DetailsRouter()
    
    init(viewModel: GrapeViewModel) {
        self.viewModel = viewModel
    }

    func makeModalExtraDetailsView<Label: View>(viewModel: GrapeViewModel, @ViewBuilder label: () -> Label) -> AnyView {
        router.makeModalExtraDetailsView(viewModel: viewModel, label: label)
    }
}
