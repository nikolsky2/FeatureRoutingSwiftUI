//
//  ExtraDetailsRouter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI

protocol ExtraDetailsFeatureRouting {
    func makeModalExtraDetailsView<Label: View>(viewModel: GrapeViewModel, @ViewBuilder label: () -> Label) -> AnyView
}

extension ExtraDetailsFeatureRouting {
    func makeModalExtraDetailsView<Label: View>(viewModel: GrapeViewModel, @ViewBuilder label: () -> Label) -> AnyView {
        label()
            .makeSheet {
                NavigationView {
                    ExtraDetailsView.make(viewModel: viewModel)
                }
            }
            .anyView
    }
}
