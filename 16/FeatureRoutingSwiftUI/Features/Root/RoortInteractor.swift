//
//  RoortInteractor.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 15/7/2022.
//

import Foundation

public
protocol RootInteracting: Actor {
    func fetch() async throws -> [RootModel]
}

public
actor RootInteractor: RootInteracting {
    let apiClient: APIClientProtocol

    public
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    public
    func fetch() async throws -> [RootModel] {
        try await apiClient.fetch()
    }
}
