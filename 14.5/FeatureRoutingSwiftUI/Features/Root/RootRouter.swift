//
//  RootRouter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI
import DetailsKit
import ExtraDetailsKit
import NavigationBackport
import UIExtensionsKit

@MainActor
class RootRouter: ObservableObject {
    @Published var path = NBNavigationPath()
    @Published var presentationStyle: PresentationStyle = .detailsStack

    var makeDataViewModelById: ((UUID) -> DataViewModel?)?

    private func popToRoot() {
        path.removeLast(path.count)
    }
}

extension RootRouter: RootRouting {
    func makeNavigationView<Label: View>(viewModels: [DataViewModel],
                                          @ViewBuilder label: @escaping (DataViewModel) -> Label) -> AnyView {
        List {
            ForEach(viewModels) { viewModel in
                switch self.presentationStyle {
                case .detailsStack, .extraDetailsStack:
                    NBNavigationLink(value: viewModel) {
                        label(viewModel)
                    }
                case .detailsModally:
                    label(viewModel)
                        .makeSheet {
                            NavigationView {
                                DetailsView.make(viewModel: viewModel.makeDetailsViewModel(), router: self)
                            }
                        }
                        .anyView
                case .extraDetailsModally:
                    label(viewModel)
                        .makeSheet {
                            NavigationView {
                                ExtraDetailsView.make(viewModel: viewModel.makeExtraDetailsViewModel())
                            }
                        }
                        .anyView
                }
            }
        }
        .nbNavigationDestination(for: DataViewModel.self, destination: { viewModel in
            switch self.presentationStyle {
            case .detailsStack:
                DetailsView.make(viewModel: viewModel.makeDetailsViewModel(), router: self)
            case .extraDetailsStack:
                ExtraDetailsView.make(viewModel: viewModel.makeExtraDetailsViewModel())
            case .detailsModally, .extraDetailsModally:
                fatalError()
            }
        })
        .nbNavigationDestination(for: DetailsKit.DetailsViewModel.self, destination: { viewModel in
            DetailsView.make(viewModel: viewModel, router: self)
        })
        .nbNavigationDestination(for: ExtraDetailsKit.ExtraDetailsViewModel.self, destination: { viewModel in
            ExtraDetailsView.make(viewModel: viewModel)
        })
        .anyView
    }
}

extension RootRouter: DetailsKit.DetailsRouting {
    func dismissDetails() {
        popToRoot()
    }

    func presentExtraDetails(_ id: UUID) {
        guard let dataViewModel = makeDataViewModelById?(id) else { return }

        // This will push only to "path" navigation stack
        path.append(dataViewModel.makeExtraDetailsViewModel())
    }
}
