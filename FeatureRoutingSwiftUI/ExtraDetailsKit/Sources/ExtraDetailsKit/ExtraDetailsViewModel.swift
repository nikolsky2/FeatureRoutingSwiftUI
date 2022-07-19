import Foundation
import UIExtensionsKit

public
struct ExtraDetailsViewModel: Hashable, Identifiable {
    public var id = UUID()
    let title: String
    let pieChartViewModels: [PieChartViewModel]

    public
    init(title: String, pieChartViewModels: [PieChartViewModel]) {
        self.title = title
        self.pieChartViewModels = pieChartViewModels
    }
}
