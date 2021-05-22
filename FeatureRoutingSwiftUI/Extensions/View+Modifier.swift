//
//  View+Modifier.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI

extension View {
    var anyView: AnyView {
        AnyView(self)
    }

    func makeSheet<T: View>(destination: @escaping () -> T) -> some View {
        modifier(SheetPresentationModifier(destination: destination))
    }

    func makeNavigation<T: View>(destination: @escaping () -> T) -> some View {
        NavigationLink(
            destination: destination()) {
            self
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
