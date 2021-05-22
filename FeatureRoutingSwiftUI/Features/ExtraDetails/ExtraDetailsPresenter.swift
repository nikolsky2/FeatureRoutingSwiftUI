//
//  ExtraDetailsPresenter.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 23/5/21.
//

import SwiftUI

class ExtraDetailsPresenter: ObservableObject {
    let viewModel: GrapeViewModel
    init(viewModel: GrapeViewModel) {
        self.viewModel = viewModel
    }
}
