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

struct RootView: View {
    @Binding var viewModels: [GrapeViewModel]

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModels) { viewModel in
                    NavigationLink(destination: DetailsView(title: viewModel.title)) {
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

// MARK: - PREVIEW

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModels: .constant(mockViewModels))
    }
}
