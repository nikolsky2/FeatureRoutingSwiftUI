//
//  DetailsRouter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI

protocol DetailsFeatureRouting {
    func makePushDetailsView<Label: View>(viewModel: GrapeViewModel, @ViewBuilder label: () -> Label) -> AnyView
    func makeModalDetailsView<Label: View>(viewModel: GrapeViewModel, @ViewBuilder label: () -> Label) -> AnyView
}

extension DetailsFeatureRouting {
    func makePushDetailsView<Label: View>(viewModel: GrapeViewModel, @ViewBuilder label: () -> Label) -> AnyView {
        label()
            .makeNavigation {
                DetailsView.make(viewModel: viewModel)
            }
            .anyView
    }

    func makeModalDetailsView<Label: View>(viewModel: GrapeViewModel, @ViewBuilder label: () -> Label) -> AnyView {
        label()
            .makeSheet {
                NavigationView {
                    DetailsView.make(viewModel: viewModel)
                }
            }
            .anyView
    }
}

struct DetailsRouter: ExtraDetailsFeatureRouting {}
