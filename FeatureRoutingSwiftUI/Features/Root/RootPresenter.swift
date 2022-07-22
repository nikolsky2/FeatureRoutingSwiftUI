//
//  RootPresenter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI
import NavigationBackport
import UIExtensionsKit
import DetailsKit
import ExtraDetailsKit

enum RootViewModel {
    case loading
    case loaded([DataViewModel])

    var isLoading: Bool {
        if case .loading = self {
           return true
        } else {
            return false
        }
    }
}

struct DataViewModel: Hashable, Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
}

private
struct Grape: Hashable, Identifiable {
    var id = UUID()
    let title: String
    let subtitle: String
    let pieChartViewModels: [PieChartViewModel]
}

private
let rawData: [Grape] = [
    .init(title: "Cabernet Sauvignon",
          subtitle: "The most famous red wine grape variety on Earth",
          pieChartViewModels: [
            PieChartViewModel(value: 2, name: "Australia", color: .blue),
            PieChartViewModel(value: 3, name: "US", color: .green),
            PieChartViewModel(value: 10, name: "Argentina", color: .orange)
          ]),
    .init(title: "Pinot Noir",
          subtitle: "The dominant red wine grape of Burgundy",
          pieChartViewModels: [
            PieChartViewModel(value: 8, name: "France", color: .red),
            PieChartViewModel(value: 10, name: "Australia", color: .green),
            PieChartViewModel(value: 2, name: "Argentina", color: .orange)
          ]),
    .init(title: "Shiraz",
          subtitle: "New World Syrah",
          pieChartViewModels: [
            PieChartViewModel(value: 1, name: "France", color: .blue),
            PieChartViewModel(value: 10, name: "Australia", color: .green),
            PieChartViewModel(value: 5, name: "US", color: .orange)
          ])
]

private
extension Grape {
    func makeDetailsViewModel() -> DetailsKit.DetailsViewModel {
        .init(id: id, title: title, subtitle: subtitle)
    }
}

private
extension Grape {
    func makeExtraDetailsViewModel() -> ExtraDetailsKit.ExtraDetailsViewModel {
        .init(id: id, title: title, pieChartViewModels: pieChartViewModels)
    }
}

private
extension Grape {
    func makeDataViewModel() -> DataViewModel {
        .init(id: id, title: title, subtitle: subtitle)
    }
}

private
extension Array where Element == RootModel {
    func makeViewModels() -> [DataViewModel] {
        rawData.map { $0.makeDataViewModel() }
    }
}

enum PresentationStyle {
    case detailsStack
    case detailsModally
    case extraDetailsModally
    case extraDetailsStack

    var title: String {
        switch self {
        case .detailsStack:
            return "Push Details on Stack"
        case .detailsModally:
            return "Show Details Modally"
        case .extraDetailsStack:
            return "Push ExtraDetails on Stack"
        case .extraDetailsModally:
            return "Show ExtraDetails Modally"
        }
    }
}

@MainActor
class RootPresenter: ObservableObject {
    @Published var viewModel = RootViewModel.loading
    @Published var presentationStyle: PresentationStyle = .detailsStack
    @Published var path = NBNavigationPath()

    private let router: RootRouter
    private let interactor: RootInteracting

    init(interactor: RootInteracting, router: RootRouter) {
        self.interactor = interactor
        self.router = router
    }

    func fetch() {
        Task {
            do {
                let models = try await interactor.fetch()
                self.viewModel = .loaded(models.makeViewModels())
            } catch {
                // Error
            }
        }
    }

    /**
     https://developer.apple.com/documentation/swiftui/view/navigationdestination(for:destination:)

     NavigationStack {
         List {
             NavigationLink("Mint", value: Color.mint)
             NavigationLink("Pink", value: Color.pink)
             NavigationLink("Teal", value: Color.teal)
         }
         .navigationDestination(for: Color.self) { color in
             ColorDetail(color: color)
         }
         .navigationTitle("Colors")
     }
     */
    func makeNavigationView<Label: View>(viewModels: [DataViewModel],
                                          @ViewBuilder label: @escaping (DataViewModel) -> Label) -> AnyView {
        List {
            ForEach(viewModels) { viewModel in
                NBNavigationLink(value: viewModel) {
                    label(viewModel)
                }
            }
        }
        .nbNavigationDestination(for: DataViewModel.self, destination: { value in
            switch self.presentationStyle {
            case .detailsStack:
                DetailsView.make(viewModel: rawData.first { $0.id == value.id }!.makeDetailsViewModel(),
                                 dismiss: {
                    self.popToRoot()
                })
            case .extraDetailsStack:
                ExtraDetailsView.make(viewModel: rawData.first { $0.id == value.id }!.makeExtraDetailsViewModel())
            case .detailsModally:
                fatalError()
            case .extraDetailsModally:
                fatalError()
            }
        })
        .nbNavigationDestination(for: DetailsKit.DetailsViewModel.self, destination: { value in
            DetailsView.make(viewModel: value,
                             dismiss: {
                self.popToRoot()
            })
        })
        .nbNavigationDestination(for: ExtraDetailsKit.ExtraDetailsViewModel.self, destination: { value in
            ExtraDetailsView.make(viewModel: value)
        })
        .anyView
    }

    func pushView() {
        path.append(rawData[0].makeDetailsViewModel())
    }

    func pushSeveralViews() {
        path.append(rawData[0].makeDetailsViewModel())

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.path.append(rawData[1].makeExtraDetailsViewModel())
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.path.append(rawData[2].makeDetailsViewModel())
        }
    }

    private func popToRoot() {
        path.removeLast(path.count)
    }
}
