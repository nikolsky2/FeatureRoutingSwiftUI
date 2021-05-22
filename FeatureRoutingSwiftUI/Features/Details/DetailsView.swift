//
//  DetailsView.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI

struct DetailsView: View {
    @StateObject var presenter: DetailsPresenter

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                HStack {
                    Text("Grape variety")
                        .font(.footnote)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    Text(presenter.viewModel.title)
                        .font(.headline)
                        .foregroundColor(Color(UIColor.label))
                    Spacer()
                }
                .padding()
                Divider()
                HStack {
                    Text("Description")
                        .font(.footnote)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    Text(presenter.viewModel.subtitle)
                        .font(.headline)
                        .foregroundColor(Color(UIColor.label))
                }
                .padding()
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .toolbar {
            presenter.makeModalExtraDetailsView(viewModel: presenter.viewModel) {
                Text("Show Regions")
            }
        }
    }
}

extension DetailsView {
    static func make(viewModel: GrapeViewModel) -> DetailsView {
        let presenter = DetailsPresenter(viewModel: viewModel)
        return DetailsView(presenter: presenter)
    }
}

// MARK: - PreviewProvider

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView.make(viewModel: mockViewModels[0])
        }
    }
}
