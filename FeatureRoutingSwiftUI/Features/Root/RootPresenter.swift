//
//  RootPresenter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI

struct GrapeViewModel: Identifiable {
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

class RootPresenter: ObservableObject {
    @Published var viewModels: [GrapeViewModel] = mockViewModels
    private let router = RootRouter()

    //Note: Intractor is deliberatelly omitted here for the simplicity sake

    func makeDestinationView<Label: View>(viewModel: GrapeViewModel, @ViewBuilder label: () -> Label) -> AnyView {
        router.makeDestinationView(viewModel: viewModel, label: label)
    }
}
