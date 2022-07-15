//
//  RootView.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import NavigationBackport
import SwiftUI

struct RootView: View {
    @StateObject var presenter: RootPresenter
    @State private var path = NBNavigationPath()

    var body: some View {
        NBNavigationStack(path: $path) {
            switch presenter.viewModel {
            case .loading:
                VStack {
                    HStack(spacing: 8) {
                        ProgressView()
                        Text("Loading...")
                            .font(.headline)
                    }
                    Spacer()
                }
            case .loaded(let viewModels):
                List {
                    ForEach(viewModels) { viewModel in
                        presenter.makeDestinationView(viewModel: viewModel,
                                                      dismiss: {
                            path.removeLast(path.count)
                        }) {
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu(presenter.presentationStyle.title) {
                            Button(action: {
                                presenter.presentationStyle = .detailsStack
                            }) {
                                Text(PresentationStyle.detailsStack.title)
                                if presenter.presentationStyle == .detailsStack { Image(systemName: "checkmark") }
                            }
                            Button(action: {
                                presenter.presentationStyle = .detailsModally
                            }) {
                                Text(PresentationStyle.detailsModally.title)
                                if presenter.presentationStyle == .detailsModally { Image(systemName: "checkmark") }
                            }
                            Button(action: {
                                presenter.presentationStyle = .extraDetailsModally
                            }) {
                                Text(PresentationStyle.extraDetailsModally.title)
                                if presenter.presentationStyle == .extraDetailsModally { Image(systemName: "checkmark") }
                            }
                            Divider()
                            Text("Deep linking")
                            Button(action: {
                                path.append(mockViewModels[0])
                            }) {
                                Text("Push programatically")
                            }
                            Button(action: {
                                $path.withDelaysIfUnsupported {
                                  $0.append(mockViewModels[0])
                                  $0.append(mockViewModels[1])
                                }
                            }) {
                                Text("Push 2 screens programatically")
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            presenter.fetch()
        }
    }
}

extension RootView {
    static func make() -> RootView {
        let presenter = RootPresenter(interactor: RootInteractor(),
                                      router: RootRouter())
        return RootView(presenter: presenter)
    }
}

// MARK: - PreviewProvider

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView.make()
    }
}
