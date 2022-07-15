//
//  ExtraDetailsPresenter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI

@MainActor
class ExtraDetailsPresenter: ObservableObject {
    @Published var viewModel: GrapeViewModel
    init(viewModel: GrapeViewModel) {
        self.viewModel = viewModel
    }
}
