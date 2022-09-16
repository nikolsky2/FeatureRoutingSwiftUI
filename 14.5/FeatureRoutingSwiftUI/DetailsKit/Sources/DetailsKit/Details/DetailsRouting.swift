//
//  DetailsRouting.swift
//  
//
//  Created by Sergey Nikolsky on 2/9/2022.
//

import SwiftUI
import UIExtensionsKit

@MainActor
public
protocol DetailsRouting {
    func dismissDetails()
    func presentExtraDetails(_ id: UUID)
}
