//
//  View+Modifier.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI

public
extension View {
    var anyView: AnyView {
        AnyView(self)
    }

    func makeSheet<T: View>(destination: @escaping () -> T) -> some View {
        modifier(SheetPresentationModifier(destination: destination))
    }

    func makeNavigation<P: Hashable, T: View>(value: P, destination: @escaping (P) -> T) -> some View {
        NavigationLink(value: value) {
            self
            .navigationDestination(for: P.self, destination: { value in
                destination(value)
            })
        }
    }
}

private struct SheetPresentationModifier<T: View>: ViewModifier {
    let destination: () -> T

    @State private var isPresented: Bool = false

    func body(content: Content) -> some View {
        content
            .onTapGesture {
                self.isPresented = true
            }
            .sheet(isPresented: $isPresented, content: {
                destination()
            })
    }
}
