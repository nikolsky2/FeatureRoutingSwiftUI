//
//  ExtraDetailsView.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI

struct ExtraDetailsView: View {
    @StateObject var presenter: ExtraDetailsPresenter

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
    static func make(viewModel: GrapeViewModel) -> ExtraDetailsView {
        let presenter = ExtraDetailsPresenter(viewModel: viewModel)
        return ExtraDetailsView(presenter: presenter)
    }
}

struct ExtraDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExtraDetailsView.make(viewModel: mockViewModels[0])
        }
    }
}
