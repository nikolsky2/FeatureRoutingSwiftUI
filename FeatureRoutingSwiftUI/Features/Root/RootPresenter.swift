//
//  RootPresenter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI

enum RootViewModel {
    case loading
    case loaded([GrapeViewModel])

    var isLoading: Bool {
        if case .loading = self {
           return true
        } else {
            return false
        }
    }
}

struct GrapeViewModel: Hashable, Identifiable {
    var id = UUID()
    let title: String
    let subtitle: String
    let pieChartViewModels: [PieChartViewModel]
}

let mockViewModels: [GrapeViewModel] = [
    .init(title: "Cabernet Sauvignon",
          subtitle: "The most famous red wine grape variety on Earth",
          pieChartViewModels: [
            PieChartViewModel(value: 2, name: "Australia", color: .blue),
            PieChartViewModel(value: 3, name: "US", color: .green),
            PieChartViewModel(value: 10, name: "Argentina", color: .orange)
          ]),
    .init(title: "Pinot Noir",
          subtitle: "The dominant red wine grape of Burgundy",
          pieChartViewModels: [
            PieChartViewModel(value: 8, name: "France", color: .red),
            PieChartViewModel(value: 10, name: "Australia", color: .green),
            PieChartViewModel(value: 2, name: "Argentina", color: .orange)
          ]),
    .init(title: "Shiraz",
          subtitle: "New World Syrah",
          pieChartViewModels: [
            PieChartViewModel(value: 1, name: "France", color: .blue),
            PieChartViewModel(value: 10, name: "Australia", color: .green),
            PieChartViewModel(value: 5, name: "US", color: .orange)
          ])
]

extension Array where Element == RootModel {
    func makeViewModels() -> [GrapeViewModel] {
        mockViewModels
    }
}

enum PresentationStyle {
    case detailsStack
    case detailsModally
    case extraDetailsModally

    var title: String {
        switch self {
        case .detailsStack:
            return "Push Details on Stack"
        case .detailsModally:
            return "Show Details Modally"
        case .extraDetailsModally:
            return "Show ExtraDetails Modally"
        }
    }
}

@MainActor
class RootPresenter: ObservableObject {
    @Published var viewModel = RootViewModel.loading
    @Published var presentationStyle: PresentationStyle = .detailsStack

    private let router: RootRouter
    private let interactor: RootInteracting

    init(interactor: RootInteracting, router: RootRouter) {
        self.interactor = interactor
        self.router = router
    }

    func fetch() {
        Task {
            do {
                let models = try await interactor.fetch()
                self.viewModel = .loaded(models.makeViewModels())
            } catch {
                // Error
            }
        }
    }

    func makeDestinationView<Label: View>(viewModel: GrapeViewModel, @ViewBuilder label: () -> Label) -> AnyView {

        // Dynamic routing is here

        switch presentationStyle {
        case .detailsStack:
            return router.makePushDetailsView(viewModel: viewModel, label: label)
        case .detailsModally:
            return router.makeModalDetailsView(viewModel: viewModel, label: label)
        case .extraDetailsModally:
            return router.makeModalExtraDetailsView(viewModel: viewModel, label: label)
        }
    }
}
