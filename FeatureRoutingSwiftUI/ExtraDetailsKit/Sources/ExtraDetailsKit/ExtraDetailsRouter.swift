//
//  ExtraDetailsRouter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI
import UIExtensionsKit

@MainActor
public
protocol ExtraDetailsFeatureRouting {
    func makeModalExtraDetailsView<Label: View>(viewModel: ExtraDetailsViewModel, @ViewBuilder label: () -> Label) -> AnyView
}

public
extension ExtraDetailsFeatureRouting {
    func makeModalExtraDetailsView<Label: View>(viewModel: ExtraDetailsViewModel, @ViewBuilder label: () -> Label) -> AnyView {
        label()
            .makeSheet {
                NavigationView {
                    ExtraDetailsView.make(viewModel: viewModel)
                }
            }
            .anyView
    }
}
