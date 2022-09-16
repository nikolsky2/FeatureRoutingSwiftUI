//
//  RootModel.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 15/7/2022.
//

import UIExtensionsKit
import Foundation

public
struct RootModel: Decodable {
    var id = UUID()
    let title: String
    let subtitle: String
    let pieChartViewModels: [PieChartViewModel]
}
