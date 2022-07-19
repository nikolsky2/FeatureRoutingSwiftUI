//
//  DetailsRouter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI
import UIExtensionsKit

@MainActor
public
protocol DetailsFeatureRouting {
    func makePushDetailsView<Label: View>(viewModel: DetailsViewModel,
                                          dismiss: @escaping () -> Void,
                                          @ViewBuilder label: () -> Label) -> AnyView
    func makeModalDetailsView<Label: View>(viewModel: DetailsViewModel, @ViewBuilder label: () -> Label) -> AnyView
}

public
extension DetailsFeatureRouting {
    func makePushDetailsView<Label: View>(viewModel: DetailsViewModel,
                                          dismiss: @escaping () -> Void,
                                          @ViewBuilder label: () -> Label) -> AnyView {
        label()
            .makeNavigation(value: viewModel) { viewModel in
                DetailsView.make(viewModel: viewModel, dismiss: dismiss)
            }
            .anyView
    }

    func makeModalDetailsView<Label: View>(viewModel: DetailsViewModel, @ViewBuilder label: () -> Label) -> AnyView {
//        label()
//            .makeSheet {
//                NavigationView {
//                    DetailsView.make(viewModel: viewModel) {}
//                }
//            }
//            .anyView
        fatalError()
    }
}

//struct DetailsRouter: ExtraDetailsFeatureRouting {}
struct DetailsRouter {}
