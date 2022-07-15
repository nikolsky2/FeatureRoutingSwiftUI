//
//  RootAPIClient.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 15/7/2022.
//

import Foundation

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
                continuation.resume(returning: [RootModel()])
            })
        })
    }
}
