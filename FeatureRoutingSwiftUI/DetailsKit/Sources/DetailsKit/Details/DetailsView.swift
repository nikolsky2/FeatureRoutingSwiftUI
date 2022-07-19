//
//  DetailsView.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI

public
struct DetailsView: View {
    @StateObject var presenter: DetailsPresenter
    let dismiss: () -> Void

    public
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
            Button(action: {
                dismiss()
            }) {
                Text("Programatic Pop")
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .foregroundColor(.white)
            .background(Color.orange)
            .cornerRadius(6)
            .padding()
        }
        .navigationTitle("Details")
        .toolbar {
            presenter.makeExtraDetailsView(viewModel: presenter.viewModel) {
                Text("Show Regions")
            }
        }
    }
}

extension DetailsView {
    public
    static func make(viewModel: DetailsViewModel, dismiss: @escaping () -> Void) -> DetailsView {
        let presenter = DetailsPresenter(viewModel: viewModel)
        return DetailsView(presenter: presenter, dismiss: dismiss)
    }
}

// MARK: - PreviewProvider

let mockViewModels: [DetailsViewModel] = [
    .init(title: "Cabernet Sauvignon",
          subtitle: "The most famous red wine grape variety on Earth")
]

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView.make(viewModel: mockViewModels[0], dismiss: {})
        }
    }
}
