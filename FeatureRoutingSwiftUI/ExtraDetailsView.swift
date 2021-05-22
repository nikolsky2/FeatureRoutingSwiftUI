//
//  ExtraDetailsView.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI

class ExtraDetailsPresenter: ObservableObject {

}

struct ExtraDetailsView: View {
    @StateObject var presenter: ExtraDetailsPresenter

    var body: some View {
        NavigationView {
            PieChartView(viewModels: mockPieChartViewModels)
                .padding()
                .navigationTitle("Wine regions")
        }
    }
}

extension ExtraDetailsView {
    static func make() -> ExtraDetailsView {
        let presenter = ExtraDetailsPresenter()
        return ExtraDetailsView(presenter: presenter)
    }
}

private let mockPieChartViewModels = [
    PieChartViewModel(value: 2, name: "Australia", color: .blue),
    PieChartViewModel(value: 3, name: "US", color: .green),
    PieChartViewModel(value: 10, name: "Argentina", color: .orange)
]

struct ExtraDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ExtraDetailsView.make()
    }
}
