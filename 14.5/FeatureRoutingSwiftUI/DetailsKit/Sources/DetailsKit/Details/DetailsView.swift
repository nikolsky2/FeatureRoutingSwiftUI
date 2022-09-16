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
                presenter.didTouchDismiss()
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
        .navigationTitle(presenter.viewModel.title)
        .toolbar {
            Button {
                presenter.didTouchExtra()
            } label: {
                Text("Show Extra Details")
            }
        }
    }
}

extension DetailsView {
    public
    static func make(viewModel: DetailsViewModel,
                     router: DetailsRouting) -> DetailsView {
        let presenter = DetailsPresenter(viewModel: viewModel, router: router)
        return DetailsView(presenter: presenter)
    }
}

// MARK: - PreviewProvider

private let mockViewModel = DetailsViewModel(id: UUID(),
                                             title: "Cabernet Sauvignon",
                                             subtitle: "The most famous red wine grape variety on Earth")

struct MockDetailsRouter: DetailsRouting {
    func dismissDetails() {}
    func presentExtraDetails(_ id: UUID) {}
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView.make(viewModel: mockViewModel,
                             router: MockDetailsRouter())
        }
    }
}
