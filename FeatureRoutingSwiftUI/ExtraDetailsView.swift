//
//  ExtraDetailsView.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI

struct ExtraDetailsView: View {
    var body: some View {
        NavigationView {
            PieChartView(viewModels: mockPieChartViewModels)
                .padding()
                .navigationTitle("Wine regions")
        }
    }
}

private let mockPieChartViewModels = [
    PieChartViewModel(value: 2, name: "Australia", color: .blue),
    PieChartViewModel(value: 3, name: "US", color: .green),
    PieChartViewModel(value: 10, name: "Argentina", color: .orange)
]

struct ExtraDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ExtraDetailsView()
    }
}
