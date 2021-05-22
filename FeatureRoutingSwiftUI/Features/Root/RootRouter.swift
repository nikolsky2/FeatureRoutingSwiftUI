//
//  RootRouter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI

struct RootRouter {
    func makeDestinationView<Label: View>(viewModel: GrapeViewModel, @ViewBuilder label: () -> Label) -> AnyView {

        // NOTE: This is where we decide on what View to present and presentation style !

        // 1. Push DetailsView on navigation stack
        makePushDetailsView(viewModel: viewModel, label: label)

//         2. Present DetailsView modally
//        makeModalDetailsView(viewModel: viewModel, label: label)

        // 3. Present ExtraDetailsView modally
//        makeModalExtraDetailsView(viewModel: viewModel, label: label)
    }
}

extension RootRouter: DetailsFeatureRouting, ExtraDetailsFeatureRouting {}
