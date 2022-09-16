//
//  RootAPIClient.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 15/7/2022.
//

import Foundation
import UIExtensionsKit

private
let models: [RootModel] = [
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

public
protocol APIClientProtocol {
    func fetch() async throws -> [RootModel]
}

public
class APIClient: APIClientProtocol {
    public init() {}

    public
    func fetch() async throws -> [RootModel] {
        await withCheckedContinuation({ (continuation: CheckedContinuation<[RootModel], Never>) in

            // Fake networking
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                continuation.resume(returning: models)
            })
        })
    }
}
