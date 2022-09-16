//
//  ExtraDetailsView.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI
import UIExtensionsKit

public
struct ExtraDetailsView: View {
    @StateObject var presenter: ExtraDetailsPresenter

    public
    var body: some View {
        VStack(alignment: .leading) {
            Text("Wine regions")
                .font(.headline)
                .padding()
            PieChartView(viewModels: presenter.viewModel.pieChartViewModels)
                .padding()
        }
        .navigationTitle(presenter.viewModel.title)
    }
}

extension ExtraDetailsView {
    public
    static func make(viewModel: ExtraDetailsViewModel) -> ExtraDetailsView {
        let presenter = ExtraDetailsPresenter(viewModel: viewModel)
        return ExtraDetailsView(presenter: presenter)
    }
}

private let mockViewModel = ExtraDetailsViewModel(id: UUID(),
                                                  title: "Cabernet Sauvignon",
                                                  pieChartViewModels: [
                                                    PieChartViewModel(value: 2, name: "Australia", color: .blue),
                                                    PieChartViewModel(value: 3, name: "US", color: .green),
                                                    PieChartViewModel(value: 10, name: "Argentina", color: .orange)
                                                  ])

struct ExtraDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExtraDetailsView.make(viewModel: mockViewModel)
        }
    }
}
