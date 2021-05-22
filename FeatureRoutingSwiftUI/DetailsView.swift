//
//  DetailsView.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI

struct DetailsView: View {
    let title: String
    @State private var isPresentingExtraDetails: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                HStack {
                    Text("Grape variety")
                        .font(.footnote)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    Text("\(title)")
                        .font(.headline)
                        .foregroundColor(Color(UIColor.label))
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .toolbar {
            Button("Show Regions") {
                self.isPresentingExtraDetails = true
            }
        }
        .sheet(isPresented: $isPresentingExtraDetails) {
            ExtraDetailsView()
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView(title: "Cabernet Sauvignon")
        }
    }
}
