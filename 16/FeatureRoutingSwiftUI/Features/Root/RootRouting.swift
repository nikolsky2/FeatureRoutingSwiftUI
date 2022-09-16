//
//  RootRouting.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 2/9/2022.
//

import SwiftUI

enum PresentationStyle: CaseIterable {
    case detailsStack
    case extraDetailsStack
    case detailsModally
    case extraDetailsModally

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
protocol RootRouting: ObservableObject {
    var path: NavigationPath { get set }
    var presentationStyle: PresentationStyle { get set }
    func makeNavigationView<Label: View>(viewModels: [DataViewModel],
                                          @ViewBuilder label: @escaping (DataViewModel) -> Label) -> AnyView
}
