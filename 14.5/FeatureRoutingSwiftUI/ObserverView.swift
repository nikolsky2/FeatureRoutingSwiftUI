//
//  MyView.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 19/8/2022.
//

import SwiftUI
import Combine

/*

 - This MyView has MyPresenter containing MyRouter
 - MyRouter events have to trigger updates in the MyView

 */

@MainActor
class MyRouter: ObservableObject {
    @Published var var1: Bool = false
}

@MainActor
class MyPresenter: ObservableObject {
    @Published var var2: Bool = false
    @Published var router = MyRouter()

    private var cancellable1: AnyCancellable?
    init() {
        self.cancellable1 = self.router.$var1
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
    }
}

struct MyView: View {
    @StateObject var presenter = MyPresenter()

    var body: some View {
        VStack {
            Button {

                // PROBLEM IS HERE: VIEW DOES NOT UPDATE
                presenter.router.var1.toggle()
            } label: {
                Text("Selected MyRouter: \(presenter.router.var1 ? "TRUE" : "FALSE")")
            }
            .padding()

            Button {
                presenter.var2.toggle()
            } label: {
                Text("Selected MyPresenter: \(presenter.var2 ? "TRUE" : "FALSE")")
            }
            .padding()
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
