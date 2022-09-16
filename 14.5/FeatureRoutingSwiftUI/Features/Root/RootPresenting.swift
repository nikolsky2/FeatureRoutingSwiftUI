//
//  RootPresenting.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 29/7/2022.
//

import SwiftUI

@MainActor
protocol RootPresenting: ObservableObject {
    var title: String { get }

    associatedtype Router: RootRouting
    var router: Router { get set }
    var state: RootViewState { get }
    func fetch()

    // Deep linking
    func pushView()
    func pushSeveralViews()
}
