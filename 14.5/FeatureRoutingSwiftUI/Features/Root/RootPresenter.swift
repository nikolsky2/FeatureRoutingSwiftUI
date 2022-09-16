//
//  RootPresenter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI
import UIExtensionsKit
import DetailsKit
import ExtraDetailsKit

enum RootViewState {
    case loading
    case loaded([DataViewModel])

    var isLoading: Bool {
        if case .loading = self {
           return true
        } else {
            return false
        }
    }

    var viewModels: [DataViewModel] {
        switch self {
        case .loading:
            return []
        case .loaded(let viewModels):
            return viewModels
        }
    }
}

struct DataViewModel: Hashable, Identifiable {
    var id = UUID()
    let title: String
    let subtitle: String
    let pieChartViewModels: [PieChartViewModel]
}

extension DataViewModel {
    func makeDetailsViewModel() -> DetailsKit.DetailsViewModel {
        .init(id: id, title: title, subtitle: subtitle)
    }
}

extension DataViewModel {
    func makeExtraDetailsViewModel() -> ExtraDetailsKit.ExtraDetailsViewModel {
        .init(id: id, title: title, pieChartViewModels: pieChartViewModels)
    }
}

private
extension Array where Element == RootModel {
    func makeViewModels() -> [DataViewModel] {
        map { .init(id: $0.id,
                    title: $0.title,
                    subtitle: $0.subtitle,
                    pieChartViewModels: $0.pieChartViewModels) }
    }
}

import Combine

@MainActor
class RootPresenter: ObservableObject {
    let title = "Wine Grapes"

    @Published var state = RootViewState.loading
    @Published var router: RootRouter
    private let interactor: RootInteracting

    private var cancellable1: AnyCancellable?
    private var cancellable2: AnyCancellable?

    init(interactor: RootInteracting, router: RootRouter) {
        self.interactor = interactor
        self.router = router

        router.makeDataViewModelById = { id in
            return self.state.viewModels.first(where: { $0.id == id })
        }

        self.cancellable1 = self.router.$presentationStyle
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
        self.cancellable2 = self.router.$path
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
    }
}

extension RootPresenter: RootPresenting {
    func fetch() {
        Task {
            do {
                let models = try await interactor.fetch()
                self.state = .loaded(models.makeViewModels())
            } catch {
                // Error
            }
        }
    }

    ///
    /// These 2 methods are data driven, that's why staying in Presenter
    /// Router doesn't have data layer
    ///
    func pushView() {
        router.path.append(state.viewModels[0].makeDetailsViewModel())
    }

    func pushSeveralViews() {
        router.path.append(state.viewModels[0].makeDetailsViewModel())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.router.path.append(self.state.viewModels[1].makeExtraDetailsViewModel())
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.router.path.append(self.state.viewModels[2].makeDetailsViewModel())
        }
    }
}

