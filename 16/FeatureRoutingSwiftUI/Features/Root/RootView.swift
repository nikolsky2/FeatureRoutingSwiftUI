//
//  RootView.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI

struct RootView<P: RootPresenting>: View {
    @StateObject var presenter: P

    var body: some View {
        NavigationStack(path: $presenter.router.path) {
            switch presenter.state {
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
                presenter.router.makeNavigationView(viewModels: viewModels) { viewModel in
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
                .navigationTitle(presenter.title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu(presenter.router.presentationStyle.title) {
                            ForEach(PresentationStyle.allCases, id: \.self) { style in
                                Button(action: {
                                    presenter.router.presentationStyle = style
                                }) {
                                    Text(style.title)
                                    if presenter.router.presentationStyle == style { Image(systemName: "checkmark") }
                                }
                            }
                            Divider()
                            Text("Deep linking")
                            Button(action: {
                                presenter.pushView()
                            }) {
                                Text("Push 1 Details Programatically")
                            }
                            Button(action: {
                                presenter.pushSeveralViews()
                            }) {
                                Text("Push 2 Details and 1 Extra Details Programatically")
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
    static func make() -> RootView<RootPresenter> {
        let presenter = RootPresenter(interactor: RootInteractor(),
                                      router: RootRouter())
        return RootView<RootPresenter>(presenter: presenter)
    }

    static func makeMock() -> RootView<MockRootPresenter> {
        let presenter = MockRootPresenter()
        return RootView<MockRootPresenter>(presenter: presenter)
    }
}

// MARK: - PreviewProvider

import UIExtensionsKit

class MockRootPresenter: RootPresenting {
    let title = "Wine Grapes (Preview)"

    @Published var state = RootViewState.loaded([
        .init(title: "Merlot",
              subtitle: "Merlot is a dark blue–colored wine grape variety, that is used as both a blending grape and for varietal wines.",
              pieChartViewModels: [
                PieChartViewModel(value: 5, name: "Australia", color: .blue),
                PieChartViewModel(value: 5, name: "US", color: .green),
              ]),
        .init(title: "Sangiovese",
              subtitle: "Sangiovese is a red Italian wine grape",
              pieChartViewModels: [
                PieChartViewModel(value: 9, name: "Italy", color: .red),
                PieChartViewModel(value: 1, name: "Australia", color: .green),
              ]),
    ])
    @Published var router = RootRouter()
    func fetch() {}
    func pushView() {}
    func pushSeveralViews() {}
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
//        RootView<MockRootPresenter>.makeMock()
        RootView<RootPresenter>.make()
    }
}
