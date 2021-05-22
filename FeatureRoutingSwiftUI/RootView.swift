//
//  RootView.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI

struct GrapeViewModel: Identifiable {
    var id = UUID()
    let title: String
    let subtitle: String
}

let mockViewModels: [GrapeViewModel] = [
    .init(title: "Cabernet Sauvignon", subtitle: "The most famous red wine grape variety on Earth"),
    .init(title: "Pinot Noir", subtitle: "The dominant red wine grape of Burgundy"),
    .init(title: "Shiraz", subtitle: "New World Syrah")
]

class RootPresenter: ObservableObject {
    @Published var viewModels: [GrapeViewModel] = mockViewModels
}

struct RootView: View {
    @StateObject var presenter: RootPresenter

    var body: some View {
        NavigationView {
            List {
                ForEach(presenter.viewModels) { viewModel in
                    NavigationLink(destination: DetailsView.make(viewModel: viewModel)) {
                        VStack(alignment: .leading) {
                            Text(viewModel.title)
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                                .lineLimit(3)
                            Text(viewModel.subtitle)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Grapes")
        }
    }
}

extension RootView {
    static func make() -> RootView {
        let presenter = RootPresenter()
        return RootView(presenter: presenter)
    }
}

// MARK: - PreviewProvider

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView.make()
    }
}
