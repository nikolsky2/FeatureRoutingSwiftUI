//
//  ContentView.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI

let mockViewModels: [GrapeViewModel] = [
    .init(title: "Cabernet Sauvignon", subtitle: "The most famous red wine grape variety on Earth"),
    .init(title: "Pinot Noir", subtitle: "The dominant red wine grape of Burgundy"),
    .init(title: "Shiraz", subtitle: "New World Syrah")
]

struct ContentView: View {
    var body: some View {
        RootView(viewModels: .constant(mockViewModels))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
